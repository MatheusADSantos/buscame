//
//  Localizacao.swift
//  Buscame
//
//  Created by macbook-estagio on 27/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Localizacao: NSObject, MKMapViewDelegate {
    
    func converteEnderecoEmCordenadas(_ endereco:String, local:@escaping(_ local:CLPlacemark) -> Void) {
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco) { (listaDeLocalizacoes, error) in
            if let localizacao = listaDeLocalizacoes?.first {
                local(localizacao)
            }
        }
    }
}
