////
////  ButtonSearch.swift
////  Buscame
////
////  Created by macbook-estagio on 23/08/19.
////  Copyright © 2019 macbook-estagio. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//final class ButtonSearch: UIView {
//    
////    var delegate : CepViewDelegate?
////    
////    lazy var buttonSearch : UIButton = {
////        let button = UIButton()
////        button.setButtonWithImage(named: "search2", radius: 25)
////        button.addTarget(self, action: #selector(requestToAPI(_:)), for: .touchUpInside)
////        button.layer.cornerRadius = 25
////        return button
////    }()
//
//    
////    @objc func requestToAPI(_ sender:UIButton) {
////        print("ok CepViewDelegate")
////        delegate?.requestToAPI(completion: {
////            //
////        })
////    }
////
//    override init(frame: CGRect = .zero) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    //Usa-se quando vem do IB(Storyboard ou XIB)
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//extension ButtonSearch:ViewCode {
//    
//    //ADICIONANDO AS VIEWS
//    func buildViewHierarchy() {
//        addSubview(buttonSearch)
//    }
//    
//    //CONFIGURANDO AS CONSTRAINTS
//    func setupContraints() {
//        buttonSearch.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalToSuperview()
//        }
//    }
//    
//    //SETUPADDITIONAL
//    func setupAdditionalConfiguration() {
//        
//    }
//}
//
