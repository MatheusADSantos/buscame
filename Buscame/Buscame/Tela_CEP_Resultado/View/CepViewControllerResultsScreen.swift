//
//  CepViewControllerScreen.swift
//  Buscame
//
//  Created by macbook-estagio on 23/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

final class CepViewControllerResultsScreen: UIView {
    
    //MARK: - VARIAVEIS
    weak var delegate : CepViewResultsDelegate?
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let viewHeight = Constants.screenHeight*0.04
//        static let labelTitleHeight = Constants.screenHeight*0.25
//        static let heightTextFieldCepToLabel = Constants.screenHeight*0.05
//        static let heightButtonBuscarPorEndereco = Constants.screenHeight*0.1
        static let margin = Constants.screenWidth*0.05
    }
    //------------------------------------------------------------
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //------------------------------------------------------------
    
    //MARK: - COMPONENTES
    lazy var view : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: /*"81cef4"*/ "48a7d5")
        return view
    }()
    lazy var view2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        return view
    }()
    var buttonToBack : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "back", radius: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 10)
        button.addTarget(self, action: #selector(goToHome(_:)), for: .touchUpInside)
        return button
    }()
    @objc func goToHome(_ sender:Any) {
        delegate?.goToCepViewController()
    }
    var imageStates : UIImageView = {
        let image = UIImageView()
        image.setImage(name: "search", x: 0, y: 0, width: 100, height: 20)
        return image
    }()
    var labelVoltar : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Voltar", textColor: .white, font: UIFont(name: "Helvetica", size: 20), backgroundColor: .clear, textAlignment: .center)
        return label
    }()
    var labelCep : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "CEP: ", textColor: .white, font: UIFont(name: "Helvetica", size: 25), backgroundColor: UIColor().hexaToColor(hex: "48a7d5"), textAlignment: .center)
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        return label
    }()
    var labelCity : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Cidade", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelCityResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 24), backgroundColor: .clear, textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    var labelState : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Estado(UF)", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelStateResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 24), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelBairro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Bairro", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelBairroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 24), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Logradouro", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 24), backgroundColor: .clear, textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    var buttonMoreInfo : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "info", radius: 25)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.addTarget(self, action: #selector(seeMoreInfo(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        return button
    }()
    @objc func seeMoreInfo(_ sender:Any) {
        delegate?.seeMoreInfo()
    }
    var labelButtonMoreInfo : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Mais Informações", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .center)
        label.numberOfLines = 2
        return label
    }()
    var buttonSaveBookmark : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "saveToFavorite", radius: 25)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.addTarget(self, action: #selector(saveBookmark(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        return button
    }()
    @objc func saveBookmark(_ sender: Any) {
        delegate?.saveFavorites()
    }
    var labelButtonSaveBookmark : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Salvar Favoritos", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .center)
        label.numberOfLines = 2
        return label
    }()
    var buttonGoToMap : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "location", radius: 25)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.addTarget(self, action: #selector(goToMap(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        return button
    }()
    @objc func goToMap(_ sender: Any) {
        delegate?.seeOnMap()
    }
    var labelbuttonGoToMap : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Ver no Mapa", textColor: .darkGray, font: UIFont(name: "Helvetica", size: 12), backgroundColor: .clear, textAlignment: .center)
        label.numberOfLines = 2
        return label
    }()
    
    
    


    
}



extension CepViewControllerResultsScreen : ViewCode {
    
    //ADICIONANDO AS VIEWS
    func buildViewHierarchy() {
        addSubview(view)
        addSubview(view2)
        addSubview(buttonToBack)
        addSubview(labelVoltar)
        addSubview(imageStates)
        addSubview(labelCep)
        addSubview(labelCity)
        addSubview(labelCityResult)
        addSubview(labelState)
        addSubview(labelStateResult)
        addSubview(labelBairro)
        addSubview(labelBairroResult)
        addSubview(labelLogradouro)
        addSubview(labelLogradouroResult)
        addSubview(buttonMoreInfo)
        addSubview(labelButtonMoreInfo)
        addSubview(buttonSaveBookmark)
        addSubview(labelButtonSaveBookmark)
        addSubview(buttonGoToMap)
        addSubview(labelbuttonGoToMap)
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
        imageStates.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(Constants.screenHeight*0.29)
        }
        labelCep.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(Constants.screenWidth*0.1)
            make.right.equalToSuperview().offset(-Constants.screenWidth*0.1)
            make.top.equalTo(imageStates.snp.bottom).offset(-10)
        }
        labelCity.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Constants.margin)
            make.top.equalTo(imageStates.snp.bottom).offset(Constants.margin*3)
        }
        labelCityResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelCity.snp.left).offset(0)
            make.top.equalTo(labelCity.snp.bottom).offset(3)
            make.right.equalTo(labelStateResult.snp.left).offset(-5)
        }
        labelState.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-Constants.margin)
            make.top.equalTo(imageStates.snp.bottom).offset(Constants.margin*3)
        }
        labelStateResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelState.snp.left).offset(0)
            make.top.equalTo(labelState.snp.bottom).offset(3)
            make.right.equalToSuperview().offset(-10)
        }
        labelBairro.snp.makeConstraints { (make) in
            make.left.equalTo(labelCityResult.snp.left).offset(0)
            make.top.equalTo(labelCityResult.snp.bottom).offset(Constants.margin*0.8)
        }
        labelBairroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairro.snp.left).offset(0)
            make.top.equalTo(labelBairro.snp.bottom).offset(3)
        }
        labelLogradouro.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairroResult.snp.left).offset(0)
            make.top.equalTo(labelBairroResult.snp.bottom).offset(Constants.margin*0.8)
        }
        labelLogradouroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelLogradouro.snp.left).offset(0)
            make.right.equalToSuperview().offset(-Constants.margin)
            make.top.equalTo(labelLogradouro.snp.bottom).offset(3)
        }
        buttonMoreInfo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.screenHeight * 0.1)
            make.height.width.equalTo(50)
        }
        labelButtonMoreInfo.snp.makeConstraints { (make) in
            make.centerX.equalTo(buttonMoreInfo)
            make.top.equalTo(buttonMoreInfo.snp.bottom).offset(0)
            make.width.equalTo(70)
        }
        buttonSaveBookmark.snp.makeConstraints { (make) in
            make.centerY.equalTo(buttonMoreInfo)
            make.right.equalTo(buttonMoreInfo.snp.left).offset(-50)
            make.height.width.equalTo(50)
        }
        labelButtonSaveBookmark.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelButtonMoreInfo)
            make.centerX.equalTo(buttonSaveBookmark)
            make.width.equalTo(70)
        }
        buttonGoToMap.snp.makeConstraints { (make) in
            make.centerY.equalTo(buttonMoreInfo)
            make.left.equalTo(buttonMoreInfo.snp.right).offset(50)
            make.height.width.equalTo(50)
        }
        labelbuttonGoToMap.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelButtonMoreInfo)
            make.centerX.equalTo(buttonGoToMap)
            make.width.equalTo(60)
        }
    }
    
    //SETUPADDITIONAL
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

