//
//  CepViewControllerResults.swift
//  Buscame
//
//  Created by macbook-estagio on 23/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CepViewControllerResults: UIViewController, CepViewResultsDelegate, UITextFieldDelegate {
    
    //Variaveis
    var cepViewControllerResultsScreen : CepViewControllerResultsScreen!
    var cepViewController : CepViewController!
    var resultados:[[String:String]] = [[:]]
    //Vairáveis de Nofiticação
    var complemento:String = ""
    var unidade:String = ""
    var ibge:String = ""
    var gia:String = ""
    //Variáveis de Endereço e do do CoreData
    var cidade:String? = ""
    var estado:String? = ""
    var cep:String? = ""
    var bairro:String? = ""
    var logradouro:String? = ""
    
    override func loadView() {
        cepViewControllerResultsScreen = CepViewControllerResultsScreen()
        cepViewControllerResultsScreen.delegate = self
        self.view = cepViewControllerResultsScreen
        
        print("deu certo ----> \(resultados)")
        setData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardTapped()
    }
    
    //MARK: - PROTOCOLOS
    func goToCepViewController() {
        if let navigation = navigationController {
            print("Voltou para CepViewController")
            let controller = CepViewController()
            navigation.pushViewController(controller, animated: true)
//            navigation.popViewController(animated: true)
        }
    }
    
    func saveFavorites() {
        //pegando os dados a serem salvos
        guard let cep = self.cep else {return}
        guard let cidade = self.cidade else {return}
        guard let estado = self.estado else {return}
        guard let bairro = self.bairro else {return}
        guard let logradouro = self.logradouro else {return}
        //populando o array (parametro para salvar)
        let dicionario = ["cep": cep, "cidade": cidade, "estado": estado, "bairro": bairro, "logradouro": logradouro]
        //O validaCep busca no "banco" o metodo de salvar e lá mesmo ele verifica se já existe o cep cad., se não, ele salva
        let validaCep = LocaisDAO().salvaLocais(dicionarioDeLocais: dicionario, cep: cep)
        
        if validaCep {
            if let navigation = navigationController {
                let controller = BookmarkViewController()
                navigation.pushViewController(controller, animated: true)
            }
        } else {
            let alerta = UIAlertController(title: "Atenção", message: "CEP já cadastro como favorito!", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Busque por outro CEP ... ", style: .default, handler: { (make) in
                if let navigation = self.navigationController {
                    let controller = CepViewController()
                    navigation.pushViewController(controller, animated: true)
                }
            }))
            alerta.addAction(UIAlertAction(title: "Ver Favoritos!", style: .default, handler: { (make) in
                if let navigation = self.navigationController {
                    let controller = BookmarkViewController()
                    navigation.pushViewController(controller, animated: true)
                }
            }))
            alerta.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    
    //-----------------------
    func pegaEndereco() -> String {
        guard let cidade = self.cidade else {return ""}
        guard let estado = self.estado else {return ""}
        
        return cidade + "-" + estado
    }
    func seeOnMap() {
        print("Chamou seeOnMap")
        let endereco = pegaEndereco()
        print(endereco)
        
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            Localizacao().converteEnderecoEmCordenadas(endereco) { (localizacaoEncontrada) in
                let latitude = String(describing: localizacaoEncontrada.location!.coordinate.latitude)
                let longitude = String(describing: localizacaoEncontrada.location!.coordinate.longitude)
                let url:String = "waze://?ll=\(latitude),\(longitude)&navigate=yes"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    func setData() {
        print("Chamou setData")
        let imageState = self.cepViewControllerResultsScreen.imageStates
        resultados.forEach { (resultado) in
            //Setando Imagens...
            
            switch resultado["uf"]{
            case "SP":
                imageState.image = UIImage(named: "SP")
                break
            case "PR":
                imageState.image = UIImage(named: "PR")
                break
            case "TO":
                imageState.image = UIImage(named: "TO")
                break
            case "SE":
                imageState.image = UIImage(named: "SE")
                break
            case "SC":
                imageState.image = UIImage(named: "SC")
                break
            case "RS":
                imageState.image = UIImage(named: "RS")
                break
            case "RR":
                imageState.image = UIImage(named: "RR")
                break
            case "RO":
                imageState.image = UIImage(named: "RO")
                break
            case "RN":
                imageState.image = UIImage(named: "RN")
                break
            case "RJ":
                imageState.image = UIImage(named: "RJ")
                break
            case "PI":
                imageState.image = UIImage(named: "PI")
                break
            case "PE":
                imageState.image = UIImage(named: "PE")
                break
            case "PB":
                imageState.image = UIImage(named: "PB")
                break
            case "PA":
                imageState.image = UIImage(named: "PA")
                break
            case "MT":
                imageState.image = UIImage(named: "MT")
                break
            case "MS":
                imageState.image = UIImage(named: "MS")
                break
            case "MG":
                imageState.image = UIImage(named: "MG")
                break
            case "MA":
                imageState.image = UIImage(named: "MA")
                break
            case "GO":
                imageState.image = UIImage(named: "GO")
                break
            case "ES":
                imageState.image = UIImage(named: "ES")
                break
            case "CE":
                imageState.image = UIImage(named: "CE")
                break
            case "BA":
                imageState.image = UIImage(named: "BA")
                break
            case "AP":
                imageState.image = UIImage(named: "AP")
                break
            case "AM":
                imageState.image = UIImage(named: "AM")
                break
            case "AL":
                imageState.image = UIImage(named: "AL")
                break
            case "AC":
                imageState.image = UIImage(named: "AC")
                break
            case .none:
                print("nada")
            case .some(_):
                print("algum")
            }
            
            //setando a label principal
            guard let cep = resultado["cep"] else  {return}
            cepViewControllerResultsScreen.labelCep.text = "CEP: " + cep
            
            //Setando Labels
            cepViewControllerResultsScreen.labelCityResult.text = resultado["localidade"]
            cepViewControllerResultsScreen.labelStateResult.text = resultado["uf"]
            (resultado["bairro"] == "") ? (cepViewControllerResultsScreen.labelBairroResult.text = "--") : (cepViewControllerResultsScreen.labelBairroResult.text = resultado["bairro"])
            (resultado["logradouro"] == "") ? (cepViewControllerResultsScreen.labelLogradouroResult.text = "--") : (cepViewControllerResultsScreen.labelLogradouroResult.text = resultado["logradouro"])
            
            //Notificação
            guard let complemento = resultado["complemento"] else {return}
            guard let unidade = resultado["unidade"] else {return}
            guard let ibge = resultado["ibge"] else {return}
            guard let gia = resultado["gia"] else {return}
            
            (complemento != "") ? (self.complemento = complemento) : (self.complemento = "--")
            (unidade != "") ? (self.unidade = unidade) : (self.unidade = "--")
            (ibge != "") ? (self.ibge = ibge) : (self.ibge = "--")
            (gia != "") ? (self.gia = gia) : (self.gia = "--")
            
            
            
            //Pegando Endereço
            guard let cidade = resultado["localidade"] else {return}
            guard let estado = resultado["uf"] else {return}
            
            self.cidade = cidade
            self.estado = estado
            
            //Seta os Valores para o CoreData
            self.cep = cep // o valor desembrulhado do cep esta logo acima...
            //Estes dados em especificos tem que tratar
            guard let bairro = resultado["bairro"] else {return}
            guard let logradouro = resultado["logradouro"] else {return}
            (bairro != "") ? (self.bairro = bairro) : (self.bairro = "--")
            (logradouro != "") ? (self.logradouro = logradouro) : (self.logradouro = "--")
            
        }
    }
    func seeMoreInfo() {
        if let alerta = Notificacao().exibeNotificacaoDeInformacoes(self.complemento, self.unidade, self.ibge, self.gia) {
            self.present(alerta, animated: true, completion: nil)
        }
    }
    
    
}



//https://developer.apple.com/documentation/coredata/nspersistentcontainer
