//
//  EnderecoViewDelegate.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

protocol EnderecoViewDelegate : class {
    
    func backScreen()
    func goToEnderecoViewController()
    func requestToAPI()
    func addBookmarks()
    func pegaDadosDoTextField(textField : UITextField)
    
}


