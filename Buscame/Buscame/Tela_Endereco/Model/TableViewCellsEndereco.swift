//
//  TableViewCells.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import SnapKit

//Criacao do conteudo da celula da tableView
class TableViewCellsEndereco: UITableViewCell {
    var enderecoViewControllerScreen : EnderecoViewControllerScreen!
    
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
    
    
    
    static let sizeLabels = Constants.screenWidth*0.028
    //MARK: - Criando Componentes - Labels
    var labelCep : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "CEP", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelCidade : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Cidade", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelBairro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Bairro", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouro : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Logradouro", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelComplemento : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Complemento", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelUnidade : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Unidade", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelIBGE : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "IBGE", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelGIA : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "GIA", textColor: .lightGray, font: UIFont.systemFont(ofSize: sizeLabels), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    
    //MARK: -  Criando Componentes - Labels Resultados
    var labelCepResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelCidadeResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .red, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    var labelBairroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelLogradouroResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelComplementoResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelUnidadeResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelIBGEResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var labelGIAResult : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .black, font: UIFont.systemFont(ofSize: sizeLabels * 2), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Funcao chamada ao carregar a celula
    func setupViews() {
        
        //Add label in Cell
        contentView.addSubview(labelCep)
        contentView.addSubview(labelCidade)
        contentView.addSubview(labelBairro)
        contentView.addSubview(labelLogradouro)
        contentView.addSubview(labelComplemento)
        contentView.addSubview(labelUnidade)
        contentView.addSubview(labelIBGE)
        contentView.addSubview(labelGIA)
        
        contentView.addSubview(labelCepResult)
        contentView.addSubview(labelCidadeResult)
        contentView.addSubview(labelBairroResult)
        contentView.addSubview(labelLogradouroResult)
        contentView.addSubview(labelComplementoResult)
        contentView.addSubview(labelUnidadeResult)
        contentView.addSubview(labelIBGEResult)
        contentView.addSubview(labelGIAResult)
        
        
        
        
        //Add Constraints
        labelCep.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(Constants.screenHeight * 0.03)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelCepResult.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(labelCep.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelCidade.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(130)
            make.top.equalToSuperview().offset(Constants.screenHeight * 0.03)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelCidadeResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelCidade.snp.left).offset(0)
            make.top.equalTo(labelCidade.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
            make.right.equalToSuperview().offset(-10)
//            make.width.equalTo(50)
        }
        
        labelBairro.snp.makeConstraints { (make) in
            make.left.equalTo(labelCepResult.snp.left).offset(0)
            make.top.equalTo(labelCepResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelBairroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairro.snp.left).offset(0)
            make.top.equalTo(labelBairro.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelLogradouro.snp.makeConstraints { (make) in
            make.left.equalTo(labelBairroResult.snp.left).offset(0)
            make.top.equalTo(labelBairroResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelLogradouroResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelLogradouro.snp.left).offset(0)
            make.top.equalTo(labelLogradouro.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelComplemento.snp.makeConstraints { (make) in
            make.left.equalTo(labelLogradouroResult.snp.left).offset(0)
            make.top.equalTo(labelLogradouroResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelComplementoResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelComplemento.snp.left).offset(0)
            make.top.equalTo(labelComplemento.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelUnidade.snp.makeConstraints { (make) in
            make.left.equalTo(labelComplementoResult.snp.left).offset(0)
            make.top.equalTo(labelComplementoResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelUnidadeResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelUnidade.snp.left).offset(0)
            make.top.equalTo(labelUnidade.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelIBGE.snp.makeConstraints { (make) in
            make.left.equalTo(labelUnidadeResult.snp.left).offset(0)
            make.top.equalTo(labelUnidadeResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelIBGEResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelIBGE.snp.left).offset(0)
            make.top.equalTo(labelIBGE.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        labelGIA.snp.makeConstraints { (make) in
            make.left.equalTo(labelIBGEResult.snp.left).offset(0)
            make.top.equalTo(labelIBGEResult.snp.bottom).offset(Constants.distBtweenBlocs)
            make.height.equalTo(Constants.screenWidth*0.028)
        }
        labelGIAResult.snp.makeConstraints { (make) in
            make.left.equalTo(labelGIA.snp.left).offset(0)
            make.top.equalTo(labelGIA.snp.bottom).offset(Constants.distBtweenComp)
            make.height.equalTo(Constants.heigthComponentes)
        }
        
        
        
        
        
    }
    
    
    //MARK: - Setando os dados da request nas labels da cell
    func configuraCelula(_ resultado:[[String:String]]) {
        print("Resultado --- \(resultado)")
        for array in resultado {
            self.labelCepResult.text = array["cep"]
            self.labelCidadeResult.text = array["localidade"]
            
            (array["bairro"] == "") ? (self.labelBairroResult.text = "-") : (self.labelBairroResult.text = array["bairro"])
            (array["logradouro"] == "") ? (self.labelLogradouroResult.text = "-") : (self.labelLogradouroResult.text = array["logradouro"])
            (array["complemento"] == "") ? (self.labelComplementoResult.text = "-") : (self.labelComplementoResult.text = array["complemento"])
            (array["unidade"] == "") ? (self.labelUnidadeResult.text = "-") : (self.labelUnidadeResult.text = array["unidade"])
            (array["ibge"] == "") ? (self.labelIBGEResult.text = "-") : (self.labelIBGEResult.text = array["ibge"])
            (array["gia"] == "") ? (self.labelGIAResult.text = "-") : (self.labelGIAResult.text = array["gia"])
        }
    }
    
    
    
}
