//
//  HomeViewControllerScreen.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import Lottie

final class HomeViewControllerScreen: UIView {
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let iconeHeight = Constants.screenHeight*0.4
        static let iconeMargins = Constants.screenWidth*0.1
        
        static let titleSizeFont = Constants.device == .phone ? Constants.screenWidth*0.1 : Constants.screenWidth*0.5
        static let subTitleSizeFont = Constants.device == .phone ? Constants.screenWidth*0.05 : Constants.screenWidth*0.08
        
//        static let buttonHeight = Constants.screenWidth * 0.15
        
        static let margins = Constants.screenWidth*0.03
    }
    
    
    //MARK: - VARIAVEIS
    weak var delegate : HomeViewDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        print("device: \(Constants.device)/ screenHeight: \(Constants.screenHeight)/ screenWidth: \(Constants.screenWidth)")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //Componentes
    lazy var icone: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "icon2.png")
        return view
    }()
    lazy var labelTitle: UILabel = {
        var label = UILabel()
        label.setBasicLabel(text: "BUSCA", textColor: UIColor().hexaToColor(hex: "48a7d5"), font: nil, backgroundColor: .clear, textAlignment: .center)
        let family = UIFont.fontNames(forFamilyName: "Charis SIL")
        label.font = UIFont(name: family[3], size: 40)
        return label
    }()
    lazy var labelTitle2: UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "ME", textColor: UIColor().hexaToColor(hex: "a2c517"), font: nil, backgroundColor: .clear, textAlignment: .center)
        let family = UIFont.fontNames(forFamilyName: "Charis SIL")
        label.font = UIFont(name: family[3], size: 40)
        return label
    }()
    lazy var labelSubTitle: UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "A melhor forma de busca!", textColor: UIColor().hexaToColor(hex: "bbbbbb"), font: nil, backgroundColor: .clear, textAlignment: .center)
        label.font = UIFont.systemFont(ofSize: Constants.subTitleSizeFont)
        return label
    }()
    lazy var buttonSearchCep:UIButton = {
        let button = UIButton()
        let family = UIFont.fontNames(forFamilyName: "Charis SIL")
        button.setBasicButton(title: "CEP", font: UIFont(name: family[3], size: 30), cornerRadius: 30)
//        let family = UIFont.fontNames(forFamilyName: "Charis SIL")
//        button.setBasicButton(title: "CEP", font: UIFont(name: <#T##String#>, size: <#T##CGFloat#>))
        button.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        button.addTarget(self, action: #selector(buttonClickedCEP(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonSearchEndereco:UIButton = {
        let button = UIButton()
        let family = UIFont.fontNames(forFamilyName: "Charis SIL")
        button.setBasicButton(title: "ENDEREÇO", font: UIFont(name: family[3], size: 30), cornerRadius: 30)
        button.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        button.addTarget(self, action: #selector(buttonClickedEndereco(_ :)), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonClickedCEP (_ sender: Any) {
        delegate?.goToCepViewController()
    }
    @objc func buttonClickedEndereco (_ sender: Any) {
        delegate?.goToEnderecoViewController()
    }
    
    let animationMark = AnimationView(name: "56-location-pin")
    
    var animationBookMark : AnimatedButton = {
        let animation = AnimatedButton()
        animation.animation = Animation.named("772-bookmark-animation")
        animation.clipsToBounds = false
//        animation.setPlayRange(fromProgress: 0, toProgress: 0.7, event: .touchUpInside)
        animation.addTarget(self, action: #selector(buttonClickedToBookMark(_ :)), for: .touchUpInside)
//        animation.layer.cornerRadius = 35
//        animation.layer.borderColor = UIColor.black.cgColor
//        animation.layer.borderWidth = 2
//        animation.backgroundColor = UIColor().hexaToColor(hex: "a51b0b")
        return animation
    }()
    @objc func buttonClickedToBookMark (_ sender: Any) {
        delegate?.goToBookMarks()
    }
    
}




extension HomeViewControllerScreen : ViewCode {
    
    //Adicionar View
    func buildViewHierarchy() {
        addSubview(icone)
        addSubview(labelTitle)
        addSubview(labelTitle2)
        addSubview(labelSubTitle)
        addSubview(buttonSearchCep)
        addSubview(buttonSearchEndereco)
        addSubview(animationMark)
        addSubview(animationBookMark)
    }
    
    //Configurar Constraints
    func setupContraints() {
        icone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.iconeMargins)
            make.right.equalToSuperview().offset(-Constants.iconeMargins)
            make.top.equalToSuperview().offset(Constants.iconeMargins*1.2)
            make.height.equalTo(Constants.iconeHeight)
        }
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(icone.snp.bottom).offset(-10)
            make.centerX.equalToSuperview().offset(-28)
            make.height.equalTo(80)
        }
        labelTitle2.snp.makeConstraints { (make) in
            make.left.equalTo(labelTitle.snp.right).offset(0)
            make.centerY.equalTo(labelTitle)
            make.height.equalTo(80)
        }
        labelSubTitle.snp.makeConstraints { (make) in
            make.top.equalTo(labelTitle.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        buttonSearchCep.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.margins*2)
            make.right.equalToSuperview().offset(-Constants.margins*2)
            make.height.equalTo(60)
            make.bottom.equalTo(buttonSearchEndereco.snp.top).offset(-Constants.margins*1.5)
        }
        buttonSearchEndereco.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.margins*2)
            make.right.equalToSuperview().offset(-Constants.margins*2)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-Constants.margins*3)
        }
        animationMark.snp.makeConstraints { (make) in
//            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.equalTo(labelTitle2.snp.right).offset(-45)
            make.centerY.equalTo(labelTitle2)
        }
        animationBookMark.snp.makeConstraints { (make) in
            make.height.width.equalTo(70)
            make.right.equalToSuperview().offset(-Constants.margins*2)
            make.bottom.equalTo(buttonSearchCep.snp.top).offset(-10)
        }
    }
    
    //SetupAdditional
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor().hexaToColor(hex: "FFFFFF")
    }
}


