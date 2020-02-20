//
//  LineView.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

final class LineView: UIView {
    
    var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    //Usa-se quando vem do IB(Storyboard ou XIB)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LineView : ViewCode {
    
    //ADICIONANDO AS VIEWS
    func buildViewHierarchy() {
        addSubview(lineView)
    }
    
    //CONFIGURANDO AS CONSTRAINTS
    func setupContraints() {
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    //SETUPADDITIONAL
    func setupAdditionalConfiguration() {
        
    }
}

