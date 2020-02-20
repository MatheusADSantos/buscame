//
//  CepViewControllerScreen.swift
//  Buscame
//
//  Created by macbook-estagio on 22/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class CepViewControllerScreen: UIView {
    
    var cepASerBuscado : String = {
        let cep = String()


        return cep
    }()
    
    
    //MARK: - VARIAVEIS
    weak var delegate : CepViewDelegate?
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let viewHeight = Constants.screenHeight*0.04
        static let labelTitleHeight = Constants.screenHeight*0.25
        static let heightTextFieldCepToLabel = Constants.screenHeight*0.05
        static let heightButtonBuscarPorEndereco = Constants.screenHeight*0.1
    }
    

    
    
    //------------------------------------------------------------
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        print(cepASerBuscado)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //------------------------------------------------------------
    
    
    //COMPONENTES INICIALIZADOS
   // let buttonSearch = ButtonSearch()
    
    
    //MARK: - COMPONENTES
    lazy var view : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: /*"81cef4"*/ "48a7d5")
        return view
    }()
    lazy var view2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: "48a7d5") // /*"48a7d5"*/"81cef4"
        return view
    }()
    var buttonToBack : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "back", radius: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 10)
        button.addTarget(self, action: #selector(goToHome(_:)), for: .touchUpInside)
//        button.layer.cornerRadius = 22.5
//        button.backgroundColor = .black
        return button
    }()
    var labelVoltar : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Voltar", textColor: .white, font: UIFont(name: "Helvetica", size: 20), backgroundColor: .clear, textAlignment: .center)
//        let family  = UIFont.fontNames(forFamilyName: "Arial")
//        label.font = UIFont.init(name: family[0], size: 20)
        return label
    }()
    var labelTitle : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Digite o CEP que deseja buscar!", textColor: .black, font: UIFont(name: "Helvetica", size: 18), backgroundColor: .clear, textAlignment: .center)
        label.numberOfLines = 2
        label.textColor = .darkGray
        return label
    }()
    lazy var textFieldCep : UITextField = {
        let text = UITextField()
        text.placeholder = "17400000"
        text.font = UIFont(name: "Helvetica", size: Constants.screenWidth * 0.11)
        text.textAlignment = .left
        text.layer.borderWidth = 2
        text.layer.cornerRadius = 25
        text.layer.borderColor = (UIColor().hexaToColor(hex: "48a7d5")).cgColor
        text.recuo(20)
        return text
    }()
    var buttonSearch : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "search2", radius: 25)
        button.addTarget(self, action: #selector(requestToAPI(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    var buttonToEndereco : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor().hexaToColor(hex: "48a7d5"), for: .normal)
        button.setBasicButton(title: "Buscar por Endereço", font: UIFont.systemFont(ofSize: 25) )
        button.setaShadow(view: button, alpha: 1, offSetX: -1.2, offSetY: 0.7, shadowOpacity: 0.7, shadowRadius: 1, bolean: true)
        button.addTarget(self, action: #selector(goToEndereco(_:)), for: .touchUpInside)
        
        return button
    }()
    
//    let animateView = AnimationView(name: "2825-loading-circle")
    let animateView = AnimationView(name: "5668-loadder")
//    let animateView = AnimationView(name: "6895-loading-icon")
//    let animateView = AnimationView(name: "8682-loading")
//    let animateView = AnimationView(name: "56-location-pin")
    
    
    @objc func goToHome(_ sender:Any) {
        delegate?.goToHome()
    }
    @objc func requestToAPI(_ sender:UIButton) {
        print("Chamou a função (requestToAPI) que chamará uma das funções do delegate, no caso chamaProximaTela, passando um sender ")
        delegate?.chamaProximaTela(sender)
    }
    @objc func goToEndereco(_ sender:Any) {
        delegate?.goToEndereco()
    }
    
    
    

}



extension CepViewControllerScreen : ViewCode {
    
    //ADICIONANDO AS VIEWS
    func buildViewHierarchy() {
        addSubview(view)
        addSubview(view2)
        addSubview(buttonToBack)
        addSubview(labelVoltar)
        addSubview(labelTitle)
        addSubview(textFieldCep)
        addSubview(buttonSearch)
        addSubview(buttonToEndereco)
        addSubview(animateView)
    }
    
    //CONFIGURANDO AS CONSTRAINTS
    func setupContraints() {
        view.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(Constants.viewHeight)
        }
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom).offset(0)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(Constants.viewHeight*1.5)
        }
        buttonToBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalTo(view2)
            make.height.width.equalTo(45)
        }
        labelVoltar.snp.makeConstraints{ (make) in
            make.left.equalTo(buttonToBack.snp.right).offset(0)
            make.centerY.equalTo(view2)
        }
        labelTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view2.snp.bottom).offset(Constants.labelTitleHeight)
            make.left.equalTo(textFieldCep.snp.left).offset(0)
            make.right.equalTo(buttonSearch.snp.right).offset(0)
        }
        textFieldCep.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-25)
            make.top.equalTo(labelTitle.snp.bottom).offset(Constants.heightTextFieldCepToLabel)
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(Constants.screenWidth * 0.14)
            make.right.equalToSuperview().offset(-Constants.screenWidth * 0.14)
            make.width.equalTo(200)
        }
        buttonSearch.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.centerY.equalTo(textFieldCep)
            make.left.equalTo(textFieldCep.snp.right).offset(-56)
        }
        buttonToEndereco.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-Constants.heightButtonBuscarPorEndereco)
            make.left.equalToSuperview().offset(Constants.heightButtonBuscarPorEndereco*0.5)
            make.right.equalToSuperview().offset(-Constants.heightButtonBuscarPorEndereco*0.5)
        }
        animateView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldCep.snp.bottom).offset(10)
            make.height.width.equalTo(80)
        }
    }
    
    //SETUPADDITIONAL
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}






