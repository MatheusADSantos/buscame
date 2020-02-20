//
//  ViewCode.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import SnapKit

protocol ViewCode {
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    
    func setupView()
}
extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
