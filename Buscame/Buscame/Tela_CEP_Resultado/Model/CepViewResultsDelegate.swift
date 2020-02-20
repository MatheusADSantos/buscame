//
//  CepViewDelegate.swift
//  Buscame
//
//  Created by macbook-estagio on 23/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

protocol CepViewResultsDelegate: class {
    
    func saveFavorites()
    func seeOnMap()
    func setData()
    func goToCepViewController()
    func seeMoreInfo()
    
}
