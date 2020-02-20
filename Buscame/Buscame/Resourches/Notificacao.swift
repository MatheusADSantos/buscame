//
//  Notificacao.swift
//  Buscame
//
//  Created by macbook-estagio on 23/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

class Notificacao: NSObject {
    
    
    func exibeNotificacaoDeInformacoes(_ complemento:String, _ unidade:String, _ ibge:String, _ gia:String) -> UIAlertController? {
        let alerta = UIAlertController(title: "Informações!!!",
                                       message: """
            Complemento: \(complemento)
            Unidade: \(unidade)
            IBGE: \(ibge)
            GIA: \(gia)
            
            IBGE: Instituto Brasileiro de Geografia e Estatística
            GIA: Guia de Informação e Apuração
            """, preferredStyle: .actionSheet)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        return alerta
    }

    
    
    func exibeNotificacaoDeCamposInvalidos(_ estado:String, _ cidade:String, _ logradouro:String) -> UIAlertController? {
        if estado != "" && estado.count != 2 {
            let alerta = UIAlertController(title: "Atenção|ESTADO!!!",
                                           message: """
                O campo UF encontra-se inválido!
                Tem que ter 2 caracteres e não \(estado.count)!
                Ex: SP, RJ, GO, RS ...
                Tente Novamente!!!
                """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alerta.addAction(botao)
            return alerta
            
        } else if cidade != "" && cidade.count < 3 {
            let alerta = UIAlertController(title: "Atenção|CIDADE!!!",
                                           message: """
                O campo cidade encontra-se inválido!
                Tem que ter pelo menos 3 caracteres, não \(cidade.count)!
                Tente Novamente!!!
                """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
            
        } else if logradouro != "" && logradouro.count < 3 {
            let alerta = UIAlertController(title: "Atenção|LOGRADOURO!!!",
                                           message: """
                O campo logradouro encontra-se inválido!
                Tem que ter pelo menos 3 caracteres, não \(logradouro.count)!
                Tente Novamente!!!
                """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
        } else if estado == "" {
            let alerta = UIAlertController(title: "ATENÇÃO!!!",
                                           message: """
            Campo estado esta vazio!
            """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
        } else if cidade == "" {
            let alerta = UIAlertController(title: "ATENÇÃO!!!",
                                           message: """
            Campo cidade esta vazio!
            """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
        } else  {
            let alerta = UIAlertController(title: "ATENÇÃO!!!",
                                           message: """
            Os campos estão vazios
            """, preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return nil
        }
        
    }
    
    
    func exibeNotificacaoDeCepInvalido() -> UIAlertController? {
        let alerta = UIAlertController(title: "Atenção!!!",
                                       message: """
            O CEP informado encontra-se inválido!
            Somente números!
            Tente Novamente!!!
            """, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        return alerta
    }
    
    func exibeNotificacaoDeCepInexistente() -> UIAlertController? {
        let alerta = UIAlertController(title: "Atenção!!!",
                                       message: """
            O CEP informado não Existe!
            Tente Novamente!!!
            """, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        return alerta
    }
    
    
    func exibeNotificacaoComAsInformacoes(_ estado:String, _ cidade:String, _ logradouro:String) -> UIAlertController? {
        let alerta = UIAlertController(title: "Atenção!!!",
                                       message: """
            Dados de acordo com o CEP solicitado:\n
            Estado: \(estado)
            Cidade: \(cidade)
            Logradouro: \(logradouro)
            """, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        return alerta
    }
    
    
    
}
