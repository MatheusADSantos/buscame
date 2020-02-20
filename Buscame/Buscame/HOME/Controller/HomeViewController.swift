//
//  HomeViewController.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class HomeViewController: UIViewController, HomeViewDelegate {
    
    
    //criei uma tela do tipo HomeViewControllerScreen
    var screen: HomeViewControllerScreen!
    
    override func loadView() {
        //Estou instanciando a tela e falando quem será seu delegate e por fim falando que minha view é esa tela
        self.screen = HomeViewControllerScreen()
        self.screen.delegate = self
        view = self.screen
        
        let navigation = navigationController
        navigation?.isNavigationBarHidden = true
    }
    
    func starAnimation() {
        let view = self.screen.animationMark
        view.loopMode = .repeat(3)
//        view.loopMode = .loop
        view.animationSpeed = 0.8
        view.play()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starAnimation()
        
//        Mostando todas as famílias de font...
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font Names: \(names)")
//        }
    }
    
    
    //Implementaçao do protocolo da classe
    func goToCepViewController() {
        print("Chamou CEP")
        if let navigation = navigationController {
            navigation.pushViewController(CepViewController(), animated: true)
        }
    }
    
    func goToEnderecoViewController() {
        print("Chamou Endereco")
        if let navigation = navigationController {
            let controller = EnderecoViewController()
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func goToBookMarks() {
        self.delayWithSeconds(0.75) {
            if let navigation = self.navigationController {
                let controller = BookmarkViewController()
                navigation.pushViewController(controller, animated: true)
            }
        }
        
    }
    
    
    

}
    
    
    

