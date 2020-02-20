//
//  LocaisDAO.swift
//  Buscame
//
//  Created by macbook-estagio on 30/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import CoreData

class LocaisDAO: NSObject  {
    //CONTEXTO e GERENCIADOR DE RESULTADOS
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    var gerenciadorDeResultados:NSFetchedResultsController<Locais>?
    
    
    //SALVA  - CREATE
    func salvaLocais(dicionarioDeLocais:Dictionary<String,String>, cep: String) -> Bool {
        var local:NSManagedObject?
        let locais = retrievePlaces().first {$0.cep == cep}
        
        if locais?.cep == cep {
            print("Já existe este CEP cadastrado")
            return false
        } else {
            //criando a entidade
            let entidade = NSEntityDescription.entity(forEntityName: "Locais", in: contexto)
            local = NSManagedObject(entity: entidade!, insertInto: contexto)
            
            local?.setValue(dicionarioDeLocais["cep"], forKey: "cep")
            local?.setValue(dicionarioDeLocais["cidade"], forKey: "cidade")
            local?.setValue(dicionarioDeLocais["estado"], forKey: "estado")
            local?.setValue(dicionarioDeLocais["bairro"], forKey: "bairro")
            local?.setValue(dicionarioDeLocais["logradouro"], forKey: "logradouro")
            
            updateContext()
            return true
        }
    }
    
    //READ - RECUPERA
    func retrievePlaces() -> Array<Locais> {
        let pesquisaAluno:NSFetchRequest<Locais> = Locais.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "cidade", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        guard let listaDeCidades = gerenciadorDeResultados?.fetchedObjects else {return []}
        return listaDeCidades
    }
    
    //READ - RECUPERA EM CIMA DO SEARCHBAR
    func retrievePlaces(local : [Locais], searchText: String) -> Array<Locais> {
        var predicate : NSPredicate = NSPredicate()
        predicate = NSPredicate(format: "cidade contains[c] '\(searchText)'")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Locais")
        fetchRequest.predicate = predicate
        let ordenaPorNome = NSSortDescriptor(key: "cidade", ascending: true)
        fetchRequest.sortDescriptors = [ordenaPorNome]
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<Locais>
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        guard let listaDeCidades = gerenciadorDeResultados?.fetchedObjects else {return []}
        return listaDeCidades
    }
    
    var endereco : String = ""
    //READ - RECUPERA
    func retrieveAdress(local : [Locais], busca: String) -> String {
        let pesquisaAluno:NSFetchRequest<Locais> = Locais.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "cidade", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
//        guard let place = gerenciadorDeResultados?.fetchedObjects else {return ""}
        
        if busca == "endereco" {
            for item in local {
                guard let cidade = item.cidade else { return "" }
                guard let estado = item.estado else { return "" }
                
                let endereco = cidade + "-" + estado
                self.endereco = endereco
            }
            return self.endereco
        } else if busca == "cidade"{
            for item in local {
                guard let cidade = item.cidade else { return "" }
                
                self.endereco = cidade
            }
            return self.endereco
        } else if busca == "estado"{
            for item in local {
                guard let estado = item.estado else { return "" }
            
                self.endereco = estado
            }
            return self.endereco
        } else {
            return self.endereco
        }
    }
    
    
    
    //UPDATE - ATUALIZA
    func updateContext() {
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //DELETE - DELETA
    func deletePlace(local: Locais) {
        contexto.delete(local)
        updateContext()
    }
    
    
}
