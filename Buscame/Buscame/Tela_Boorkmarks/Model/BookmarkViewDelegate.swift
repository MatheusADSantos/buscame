//
//  BookmarkViewDelegate.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

protocol BookmarkViewDelegate: class {
    
    func backScreen()
    func goToCepViewControllerResult()
    func goToCepViewController()
    func goToHome()

    func adicionaBookmarks()
    func excluiBookmarks()
    
}
