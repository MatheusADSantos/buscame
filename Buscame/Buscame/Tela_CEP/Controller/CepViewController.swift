//
//  CepViewController.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

class CepViewController: UIViewController, CepViewDelegate, UITextFieldDelegate {
    
    //Variaveis
    var cep:String? = ""
    var resultados:[[String:String]] = [[:]]
    var cepViewControllerScreen : CepViewControllerScreen!
    
    
    override func loadView() {
        //Estou instanciando CepViewControllerScreen() em cepViewControllerScreen e
        //Falando que seu delegate 'e responsabilidade do self(CepViewController), e setei a view com ele
        //Ou seja quem toma conta da CepViewControllerScreen 'e a CepViewController e falo que a view 'e ele
        cepViewControllerScreen = CepViewControllerScreen()
        cepViewControllerScreen.delegate = self
        self.view = cepViewControllerScreen
        
        
        //Todo componente que tiver alguma logica devo setar seu delegate como sendo a self(CepViewController)
        //Ou seja, estou delegando a funcao logica destes componentes `a Controller (CepViewController)
        cepViewControllerScreen.textFieldCep.delegate = self
        cepViewControllerScreen.textFieldCep.returnKeyType = .go
        cepViewControllerScreen.textFieldCep.keyboardType = .numberPad
        cepViewControllerScreen.textFieldCep.text = cep
        if self.cep == "" {
            cepViewControllerScreen.buttonSearch.alpha = 0.3
            self.cepViewControllerScreen.buttonSearch.isUserInteractionEnabled = false
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardTapped()
        self.cepViewControllerScreen.animateView.isHidden = true
    }
    
    
    var cepInexistente : Bool = false
    
    func starAnimation() {
        let view = self.cepViewControllerScreen.animateView
        view.loopMode = .repeat(2)
        view.animationSpeed = 1.2
        self.cepViewControllerScreen.animateView.isHidden = false
        
        //Quando termina a execução da animação, execulta a completion, no caso chama o alerta.
        //Ou daria para usa o delayWithSeconds() também ... porém é mais interesante a completion()
        view.play { (true) in
            if self.cepInexistente == true {
                if let alerta = Notificacao().exibeNotificacaoDeCepInexistente() {
                    self.present(alerta, animated: true, completion: nil)
                    self.cepViewControllerScreen.animateView.isHidden = true
                }
            } else {
                if let alerta = Notificacao().exibeNotificacaoDeCepInvalido() {
                    self.present(alerta, animated: true, completion: nil)
                    self.cepViewControllerScreen.animateView.isHidden = true
                }
            }
                    }
//        self.delayWithSeconds(3) {
//            if let alerta = Notificacao().exibeNotificacaoDeCepInvalido() {
//                self.present(alerta, animated: true, completion: nil)
//            }
//        }

    }
    



    
    //Implementações do PROTOCOLO da classe
    func goToHome() {
        if let navigation = navigationController {
            print("Voltou para à tela HomeViewController")
            let controller = HomeViewController()
            navigation.pushViewController(controller, animated: true)
        }
    }
    func goToEndereco() {
        if let navigation = navigationController {
            print("Go to Endereco")
            let controller = EnderecoViewController()
            navigation.pushViewController(controller, animated: true)
        }
    }
    
//    Ao clicar no buttonSearch, chama-se esta função que tem um sender escutando o touch...
//    Ao ser chamada, ela executa a função requestToAPI, que por sua vez tem um escaping, ou seja, a requestToAPI só irá "rodar" quando escapar...E só escapará quando tiver atendido sua lógica(retornar um json)...
//    Para que a requestToAPI funcione, precisa-se de duas condições:
//    1- Clicar no buttonSearch ou dar um Enter...
//    2- executar a completion() dentro da função requestToAPI, que no caso só será executado quando for atendida a condição de retornar um json válido....
    func chamaProximaTela(_ sender : Any) {
        requestToAPI {
            let controller = CepViewControllerResults()
            controller.resultados = self.resultados
            
            if let navigation = self.navigationController {
                print("Vai para tela de CepViewControllerResults")
                navigation.pushViewController(controller, animated: true)
            }
        }
    }
    
//    Crie a requestToAPI com um escaping para garantir que ela só escape, ou seja, que esta função só funcione quando chamada em algum lugar, quando atender as condições de onde a completion() foi implementada, no caso só dentro da clousure que retorna um json...
    func requestToAPI(completion: @escaping () -> Void) {
        guard let cep = self.cep else {return}
        let urlRequest = "https://viacep.com.br/ws/" + cep + "/json/"
        print("urlRequest: ======== \(urlRequest)")
        
        RequestAPI().requestAPI(urlRequest) { (json, error, erroBool) in
            if let error = error {
                print("<><><><\(error.localizedDescription)")
                self.starAnimation()
            }
            else if let json = json{
                self.resultados = json
                print("json: ------------ \(json.count)")
                completion()
            } else {
                let erroBool = erroBool
                if erroBool == true {
                    print("poha deu certo _|_")
                    self.cepInexistente = erroBool
                    self.starAnimation()
                } else {
                    self.cepInexistente = erroBool
                    self.starAnimation()
                }
            }
        }
        
    }
    
    
    //Implementando os metodos dos textField ...
    //Buscando atraves do button
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let cep = textField.text else {return true}
        var valorFinal : String = ""
        

        //Corringindo o valor final quando usa-se o backSpace
        //Se não deu backSpace então pega o valor do text mais a string, se não, pega essa soma e da um drop no ultima posição
        if range.length == 0 {
            valorFinal = cep + string
        } else {
            let newValorFinal = cep + string
            valorFinal = String(newValorFinal.dropLast())
        }
        print(valorFinal)
        
        //Corrigindo o valor final para nao ultrapassar os 8 digitos, assim setando com valor correto o self.cep
        if valorFinal.count <= 8 {
            self.cep = valorFinal
        }
        
        //Corrigindo o valor final para setar o alpha do button e o .isUserInteractionEnabled ...
        if valorFinal.count <= 7 {
            let view = cepViewControllerScreen.buttonSearch
            UIView().setaShadow(view: view, alpha: 0.1, offSetX: -3, offSetY: 7, shadowOpacity: 0.4, shadowRadius: 4, bolean: false)
        } else {
            let view = cepViewControllerScreen.buttonSearch
            UIView().setaShadow(view: view, alpha: 1, offSetX: -3, offSetY: 7, shadowOpacity: 0.4, shadowRadius: 4, bolean: true)
        }
        
        //Retornando enquanto for menor ou igual a 8, do contrario não retorna, ou seja, não aparece na tela...
        return valorFinal.count <= 8
    }
    
    
    //Buscando atraves do Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let cep = textField.text else {return true}
        self.cep = cep
        requestToAPI {
            let controller = CepViewControllerResults()
            controller.resultados = self.resultados
            if let navigation = self.navigationController {
                print("Vai para tela de CepViewControllerResults")
                navigation.pushViewController(controller, animated: true)
            }
        }
        return true
    }
    
    
    
}



