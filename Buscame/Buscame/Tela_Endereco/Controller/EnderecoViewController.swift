//
//  EnderecoViewController.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import Lottie

class EnderecoViewController: UIViewController, EnderecoViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //MARK: - VARIAVEIS
    var enderecoViewControllerScreen : EnderecoViewControllerScreen!
    var cepViewControllerScreen : CepViewControllerScreen!
    var cepViewController : CepViewController!
    var cepViewControllerResults : CepViewControllerResults!
    var resultados:[[String:String]] = [[:]]
    var uf: String = ""
    var cidade: String = ""
    var logradouro: String = ""
    
    override func loadView() {
        enderecoViewControllerScreen = EnderecoViewControllerScreen()
        enderecoViewControllerScreen.delegate = self
        self.view = enderecoViewControllerScreen
        
        enderecoViewControllerScreen.textFieldEstado.delegate = self
        enderecoViewControllerScreen.textFieldCidade.delegate = self
        enderecoViewControllerScreen.textFieldLogradouro.delegate = self
        enderecoViewControllerScreen.textFieldCidade.text = cidade
        enderecoViewControllerScreen.textFieldEstado.text = uf
        
        enderecoViewControllerScreen.tableView.delegate = self
        enderecoViewControllerScreen.tableView.dataSource = self
        enderecoViewControllerScreen.tableView.register(TableViewCellsEndereco.self, forCellReuseIdentifier: "cellData")
        
        enderecoViewControllerScreen.textFieldCidade.keyboardType = .alphabet
        enderecoViewControllerScreen.textFieldEstado.keyboardType = .alphabet
        enderecoViewControllerScreen.textFieldLogradouro.keyboardType = .alphabet
        
        if self.cidade == "" {
            enderecoViewControllerScreen.buttonSearch.alpha = 0.3
            self.enderecoViewControllerScreen.buttonSearch.isUserInteractionEnabled = false
        } else {
            self.cidade = self.cidade.replaceName()
            print(self.cidade)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardTapped()
    }
    
    //MARK: - IMPLEMENTAÇAO DA TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultados.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Aqui estou linkando esta celula com a que registrei la em cima para pegar como referencia a classe de custo
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! TableViewCellsEndereco
        // Aqui ja consigo usar as funcoes da classe TableViewCells ...
        cell.configuraCelula([resultados[indexPath.row]])
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        //tentando quebrar linha ... :S
        cell.labelCidadeResult.numberOfLines = 2
        cell.labelCidadeResult.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*0.25 // 0.54 // MOSTRA TODOS OS DADOS
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath: \(indexPath.row)")
        let localSelecionado = resultados[indexPath.row]
        print("Local Selecionado: \(localSelecionado)")
        print("\nResultados: \(resultados)")
        
        //Tratando para quando o usuario quiser cancelar o keyboard dando um tap na tela e não iniciar o alerta de menu, assim eu garanto que o tap só vai funcionar quando o resultado for !=  vazio ...
        if resultados != [[:]] {
            let alert = UIAlertController(title: "ALERTA!!!", message: "O que deseja com este local...", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Mais Detalhes!", style: .default, handler: { (make) in
                // Redireciona
                if let navigation = self.navigationController {
                    print("Redirecionou à Tela Detalhes")
                    
                    //1 - Pegar o cep selecionado para usar na request
                    guard var cepASerBuscado = localSelecionado["cep"] else {return}
                    cepASerBuscado = cepASerBuscado.replace(target: "-", withString: "")
                    print(cepASerBuscado)
                    let url = "https://viacep.com.br/ws/" + cepASerBuscado + "/json/"
                    print("url: ----------- \(url)")
                    
                    //2 - Fazer a request, pegar o resultado dela, e, setar em resultados[[String:String]] da tela CepViewControllerResults e se retornar o json, chama-la
                    RequestAPI().requestAPI(url, completion: { (json, error, erroBool) in
                        if let error = error {
                            print("<><><><><><><><><\(error.localizedDescription)")
                        }
                        else if let json = json {
                            //Pegado a mesma tela criada, e instanciando-a para setar o resultados com o json e
                            //Consequentemente chamando a tela...
                            self.cepViewControllerResults = CepViewControllerResults()
                            self.cepViewControllerResults.resultados = json
                            navigation.pushViewController(self.cepViewControllerResults, animated: true)
                        }
                    })
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Buscar pelo Waze!", style: .default, handler: { (make) in
                self.goToMap(local: localSelecionado)
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Para deletar as células ... 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            resultados.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    //MARK: - IMPLEMENTAÇAO DO PROTOCOLO DA CLASSE
    func goToEnderecoViewController() {
        print("Chamando goToEnderecoViewController")
    }
    
    func backScreen() {
        if let navigation = navigationController {
            navigation.popToRootViewController(animated: true)
        }
    }
    
    func requestToAPI() {

        print("\n\nChamou o metodo de requestToAPI da tela Endereco ...")
        let uf = self.uf
        let cidade = self.cidade
        let logradouro = self.logradouro
        print(uf + cidade + logradouro)
        
        let urlRequest = "https://viacep.com.br/ws/" + uf + "/" + cidade + "/" + logradouro + "/json/"
        
        RequestAPI().requestAPI(urlRequest) { (json, error, erroBool) in
            if let error = error {
                print("<><><><\(error.localizedDescription)")
                self.starAnimation()
            }
            else if let json = json{
                self.view.endEditing(false)
                
                self.resultados = json
                DispatchQueue.main.async( execute: {
                    self.enderecoViewControllerScreen.tableView.reloadData()
                })
            }
        }
    }
    
    func pegaDadosDoTextField(textField: UITextField) {
        guard let dado = textField.text else {return}
        let dadosDaRequest = self.uf+self.cidade+self.logradouro
        
        if textField.tag == 0 {
            print("Estado: \(dado)")
            self.uf = dado
            print("\nDados da Request Começo da Edição : ------>>>>>>>> ", dadosDaRequest)
            if dado.count == 2 {
                setAlphaButtonSearch()
            } else {
                setAlphaButtonSearch()
            }
        } else if textField.tag == 1 {
            print("Cidade: \(dado)")
            self.cidade = dado
            print("\nDados da Request Começo da Edição : ------>>>>>>>> ", dadosDaRequest)
            if dado.count == 3 {
                setAlphaButtonSearch()
            } else {
                setAlphaButtonSearch()
            }
        } else if textField.tag == 2 {
            self.enderecoViewControllerScreen.buttonSearch.alpha = 0.3
            self.enderecoViewControllerScreen.buttonSearch.isUserInteractionEnabled = false
            print("Logradouro: \(dado)")
            self.logradouro = dado
            print("\nDados da Request Começo da Edição: ------>>>>>>>> ", dadosDaRequest)
            if dado.count == 3 {
                setAlphaButtonSearch()
            } else {
                setAlphaButtonSearch()
            }
        }
    }
    
    func addBookmarks() {
        print("Adicionando Favoritos")
    }
    
    //MARK: - Funções
    
    func starAnimation() {
        let animation = self.enderecoViewControllerScreen.animationView
        animation.loopMode = .repeat(2)
        animation.animationSpeed = 1.2
        animation.play { (true) in
            if let alerta = Notificacao().exibeNotificacaoDeCamposInvalidos(self.uf, self.cidade, self.logradouro) {
                self.present(alerta, animated: true, completion: nil)
            }
        }
    }
    
    
    func goToMap(local: [String:String]) {
        guard let cidade = local["localidade"] else {return}
        guard let estado = local["uf"] else {return}
        let endereco : String = cidade + "-" + estado
        
        print("---------->   \(endereco)")
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            Localizacao().converteEnderecoEmCordenadas(endereco) { (localizacaoEncontrada) in
                let latitude = String(describing: localizacaoEncontrada.location!.coordinate.latitude)
                let longitude = String(describing: localizacaoEncontrada.location!.coordinate.longitude)
                let url:String = "waze://?ll=\(latitude),\(longitude)&navigate=yes"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    func setAlphaButtonSearch() {
        let cidade = self.cidade.count
        let estado = self.uf.count
        let logradouro = self.logradouro.count
        
        if (cidade >= 3 && estado == 2 && (logradouro >= 3 || logradouro == 0)) {
            let buttonSearch = self.enderecoViewControllerScreen.buttonSearch
            UIView().setaShadow(view: buttonSearch, alpha: 1, offSetX: -3, offSetY: 7, shadowOpacity: 0.4, shadowRadius: 4, bolean: true)
        } else {
            let buttonSearch = self.enderecoViewControllerScreen.buttonSearch
            UIView().setaShadow(view: buttonSearch, alpha: 0.3, offSetX: -3, offSetY: 7, shadowOpacity: 0.4, shadowRadius: 4, bolean: false)
        }
    }

    
    //MARK: - IMPLEMENTAÇAO DOS PROTOCOLOS DO TEXTFIELDS
    //Chamo o método de quando começa a edição para passar como parametro o texto para o método pegaDadosDoTextField()
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            print("--Estado")
            self.pegaDadosDoTextField(textField: textField)
        case 1:
            print("--Cidade")
            self.pegaDadosDoTextField(textField: textField)
        case 2:
            print("--Logradouro")
        default:
            break
        }
    }
    //Uso para quando finaliza a edição e tratar os caracteres especiais para usar na request
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard var finalValueReplaced = textField.text else {return}
//        finalValueReplaced = finalValueReplaced.replaceName(nome: finalValueReplaced)
        finalValueReplaced = finalValueReplaced.replaceName()
        
        
        switch textField.tag {
        case 0:
            self.uf = finalValueReplaced
            break
        case 1:
            self.cidade = finalValueReplaced
            break
        case 2:
            self.logradouro = finalValueReplaced
            break
        default:
            break
        }
        let dadosDaRequest = self.uf+self.cidade+self.logradouro
        print("Dados da Request : ------>>>>>>>> ", dadosDaRequest)
    }
    //Método para controlar o tamanho do campo UF
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let dado = textField.text else {return true}
        if textField.tag == 0 {
            if(dado.count == 1 ){
                return true
            }
            let newLength = dado.count + string.count /* - range.length */
            return newLength <= 2
        } else {
            return true
        }
    }
    //Método para Enter...
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var finalValueReplaced : String = textField.text else {return true}
//        finalValueReplaced = finalValueReplaced.replaceName(nome: finalValueReplaced)
        finalValueReplaced = finalValueReplaced.replaceName()
        print("finalValueReplaced: \(finalValueReplaced)")
        
        if textField.tag == 0 {
            self.uf = finalValueReplaced
        } else if textField.tag == 1 {
            self.cidade = finalValueReplaced
        } else if textField.tag == 2 {
            self.logradouro = finalValueReplaced
        }
        
        let dadosDaRequest = self.uf+self.cidade+self.logradouro
        print("dados da request pelo enter: \(dadosDaRequest)")
        
        requestToAPI()
        return true
    }
}
