//
//  TableViewCells.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import SnapKit

import UIKit

final class TableViewCells : UITableViewCell {
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let buttonWidth = Constants.device == .phone ? Constants.screenWidth * 0.8 : Constants.screenWidth * 0.65
        static let buttonHeight = Constants.screenHeight * 0.075
        static let iconHeight = Constants.screenHeight * 2/3
        
        static let distBtweenComp = Constants.screenHeight*0.005 // 2.5
        static let distBtweenBlocs = Constants.screenHeight*0.025 // 12.5
        static let heigthComponentes = Constants.screenHeight*0.03 // 15
    }
    var locais:Locais?
    
//    static let 10 = Constants.screenWidth*0.028
    //MARK: - Criando Componentes - Labels
    var labelCidade : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Cidade", textColor: .lightGray, font: UIFont.systemFont(ofSize: 10), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelEstado : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "(UF)", textColor: .lightGray, font: UIFont.systemFont(ofSize: 10), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelCep : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "CEP", textColor: .lightGray, font: UIFont.systemFont(ofSize: 10), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelBairro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Bairro", textColor: .lightGray, font: UIFont.systemFont(ofSize: 10), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Logradouro", textColor: .lightGray, font: UIFont.systemFont(ofSize: 10), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    
    
    //MARK: -  Criando Componentes - Labels Resultados
    var labelCidadeResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .red, font: UIFont.systemFont(ofSize: 15), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelEstadoResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .red, font: UIFont.systemFont(ofSize: 15), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelCepResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: 15), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelBairroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: 15), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: 15), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
//        setCelulas()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupViews() {
        
        //Add label in Cell
        contentView.addSubview(labelCidade)
        contentView.addSubview(labelEstado)
        contentView.addSubview(labelCep)
        contentView.addSubview(labelBairro)
        contentView.addSubview(labelLogradouro)

        contentView.addSubview(labelCidadeResult)
        contentView.addSubview(labelEstadoResult)
        contentView.addSubview(labelCepResult)
        contentView.addSubview(labelBairroResult)
        contentView.addSubview(labelLogradouroResult)
        
        
        
        //Add Constraints
        
        labelCidade.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(Constants.screenHeight*0.01)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelCidadeResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelCidade)
            make.top.equalTo(labelCidade.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        labelEstado.snp.makeConstraints { (make) in
            make.left.equalTo(labelCidade.snp.right)
            make.top.equalTo(labelCidade.snp.top)
        }
        labelEstadoResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelCidadeResult.snp.right)
            make.top.equalTo(labelCidadeResult.snp.top)
            make.height.equalTo(Constants.heigthComponentes)
            
        }
        labelCep.snp.makeConstraints { (make) in
            make.left.equalTo(labelCidadeResult.snp.left).offset(0)
            make.top.equalTo(labelCidadeResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelCepResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelCep.snp.left)
            make.top.equalTo(labelCep.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        labelBairro.snp.makeConstraints { (make) in
            make.left.equalTo(labelCepResult.snp.left)
            make.top.equalTo(labelCepResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelBairroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairro.snp.left)
            make.top.equalTo(labelBairro.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        labelLogradouro.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairroResult.snp.left)
            make.top.equalTo(labelBairroResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelLogradouroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelLogradouro.snp.left)
            make.top.equalTo(labelLogradouro.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
    }
    
    //MARK: - Setando os dados da request nas labels da cell, através do CoreData ...
    func configuraCelula(_ local : Array<Locais>) {
        print("Resultado --- \([local])")
        
        for local in local {
            labelCidadeResult.text = local.cidade
            guard let estado = local.estado else {return}
            labelEstadoResult.text = " (\(String(describing: estado)))"
            labelCepResult.text = local.cep
            labelLogradouroResult.text = local.logradouro
            labelBairroResult.text = local.bairro

        }
        
    }
    
}





