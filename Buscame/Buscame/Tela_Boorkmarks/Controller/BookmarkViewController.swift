//
//  BookmarkViewController.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import CoreData

class BookmarkViewController: UIViewController, UITableViewDelegate, BookmarkViewDelegate, NSFetchedResultsControllerDelegate, NSFetchRequestResult, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    var bookmarkViewControllerScreen : BookmarkViewControllerScreen!
    var enderecoViewControllerScreen : EnderecoViewControllerScreen!
    var enderecoViewController : EnderecoViewController!
    
    var lugar : [Locais] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkViewControllerScreen = BookmarkViewControllerScreen()
        bookmarkViewControllerScreen.delegate = self
        self.view = bookmarkViewControllerScreen
        
//        enderecoViewControllerScreen = EnderecoViewControllerScreen()
//        enderecoViewController = EnderecoViewController()
        
        
        bookmarkViewControllerScreen.searchBar.delegate = self
        bookmarkViewControllerScreen.searchBar.returnKeyType = UIReturnKeyType.done
        
        bookmarkViewControllerScreen.tableView.delegate = self
        bookmarkViewControllerScreen.tableView.dataSource = self
        bookmarkViewControllerScreen.tableView.register(TableViewCells.self, forCellReuseIdentifier: "cellData")
        
        reloadInputViews()
        hideKeyboardTapped()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        lugar = LocaisDAO().retrievePlaces()
    }
    
    
    //MARK: - IMPLEMENTAÇÃO DA SEARCHBAR
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            lugar = LocaisDAO().retrievePlaces(local: self.lugar, searchText: searchText)
        } else {
            lugar = LocaisDAO().retrievePlaces()
        }
        bookmarkViewControllerScreen.tableView.reloadData()
    }
    
    
    //MARK: - IMPLEMENTAÇAO DA TABLEVIEW
    
    //Número de linhas/células ...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contadorDeLocais = lugar.count
        return contadorDeLocais
    }
    //Conteúdo de cada célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! TableViewCells
        
        //Pegando o local e setando como parametro para configurar sua célula ...
        let local = lugar[indexPath.row]
        cell.configuraCelula([local])
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    //Altura de cada célula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*0.3
    }
    //Deixando a tableView transparente ...
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
    //Deletando os favoritos(objetos do CoreData), e, as células(Row ata indexPath.row)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            //Deletando do CoreData
            let local = lugar[indexPath.row]
            LocaisDAO().deletePlace(local: local)
            //Deletando os dados da célula (E) deletando a célula
            self.lugar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let contadorDeLocais = lugar.count
            print("Number of Rows: \(contadorDeLocais)")
            //Atualizando a tableview e encerrando a edição
            tableView.reloadData()
            tableView.endUpdates()
        }
    }
    //Abrindo uma notificação ao clicar na célula ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if lugar.count != 0 && bookmarkViewControllerScreen.searchBar.enablesReturnKeyAutomatically == true {
            let alert = UIAlertController(title: "ALERTA!!!", message: "O que deseja fazer com este favorito...", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Busque pelo Endereço!", style: .default, handler: { (make) in
                // Redireciona
                if let navigation = self.navigationController {
                    print("Redirecionou à Tela Endereço")
                    //Refatorei o metódo retrieveAdress para retornar outros dois tipos de dado ...
                    let cidade:String = LocaisDAO().retrieveAdress(local: [self.lugar[indexPath.row]], busca: "cidade")
                    let estado:String = LocaisDAO().retrieveAdress(local: [self.lugar[indexPath.row]], busca: "estado")
                    //Peguei a mesma controller(enderecoViewController) e instanciei-a para setar as var com o valor retornado
                    self.enderecoViewController = EnderecoViewController()
                    self.enderecoViewController.cidade = cidade
                    self.enderecoViewController.uf = estado
                    //Chamo a mesma controller instanciado logo acima...
                    navigation.pushViewController(self.enderecoViewController, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Busque pelo Waze", style: .default, handler: { (make) in
                self.goToMap(local: [self.lugar[indexPath.row]])
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Funções
    func goToMap(local: [Locais]) {
        let endereco : String = LocaisDAO().retrieveAdress(local: local, busca: "endereco")
        
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
    
    
    
    
    //MARK: - Implementação dos protocolos
    
    func backScreen() {
        print("Voltou à tela CepViewControllerResults")
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func goToCepViewControllerResult() {
        print("Chamou o goToCepViewControllerResult")
    }
    
    func goToCepViewController() {
        print("Chamou o goToCepViewController")
    }
    
    func goToHome() {
        print("Chamou o goToHome")
        if let navigation = navigationController {
            let controller = HomeViewController()
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func adicionaBookmarks() {
        print("Chamou o adicionaBookmarks")
    }
    
    func excluiBookmarks() {
        print("Chamou o excluiBookmarks")
        
    }

}
