//
//  EnderecoViewControllerScreen.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//




import UIKit
import Lottie

final class EnderecoViewControllerScreen: UIView {
    
    //MARK: - VARIAVEIS
    
    weak var delegate : EnderecoViewDelegate?
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let buttonWidth = Constants.device == .phone ? Constants.screenWidth * 0.8 : Constants.screenWidth * 0.65
        static let buttonHeight = Constants.screenHeight * 0.075
        static let iconHeight = Constants.screenHeight * 2/3
        static let viewHeight = Constants.screenHeight*0.04
        
        static var cidadeDoFavoritos: String?
    }
    
    
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
//        setupTableView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - FUNCOES
    var frameTableView: CGRect {
        let width = Constants.screenWidth
        let height = Constants.screenHeight
        return CGRect(x: 5, y: height * 0.35, width: width - 10, height: height * 0.541)
    }
    func setupTableView() {
        tableView = UITableView(frame: frameTableView)
        self.addSubview(tableView)
    }
    
    
    
    //MARK: - COMPONENTES
    //Componentes Instanciados
//    let buttonSearch = ButtonSearchEndereco()
    let lineView = LineView()
    let lineView2 = LineView()
    let lineView3 = LineView()
    
    
    //MARK: - COMPONENTES
    var view : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: /*"81cef4"*/ "48a7d5")
        return view
    }()
    var view2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor().hexaToColor(hex: "48a7d5")
        return view
    }()
    var labelVoltar : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Voltar", textColor: .white, font: UIFont(name: "Helvetica", size: 20), backgroundColor: .clear, textAlignment: .center)
        //        let family  = UIFont.fontNames(forFamilyName: "Arial")
        //        label.font = UIFont.init(name: family[0], size: 20)
        return label
    }()
    var buttonToBack : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "back", radius: 20)
        button.imageEdgeInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 10)
        button.addTarget(self, action: #selector(backScreen(_:)), for: .touchUpInside)
        return button
    }()
    @objc func backScreen(_ sender:Any) {
        delegate?.backScreen()
    }
    var labelCidadeUser : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Cidade", textColor: .lightGray, font: UIFont.systemFont(ofSize: Constants.screenHeight*2/100), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var textFieldCidade : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cidade"
        textField.font = UIFont.systemFont(ofSize: Constants.screenHeight*4/100)
        textField.tag = 1
        textField.addTarget(self, action: #selector(pegaDados(_ :)), for: .editingChanged)
        return textField
    }()
    var labelLogradouroUser : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Logradouro", textColor: .lightGray, font: UIFont.systemFont(ofSize: Constants.screenHeight*2/100), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var textFieldLogradouro : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Logradouro"
        textField.font = UIFont.systemFont(ofSize: Constants.screenHeight*4/100)
        textField.tag = 2
        textField.addTarget(self, action: #selector(pegaDados(_ :)), for: .editingChanged)
        return textField
    }()
    var labelEstadoUser : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "UF", textColor: .lightGray, font: UIFont.systemFont(ofSize: Constants.screenHeight*2/100), backgroundColor: .clear, textAlignment: .left)
        return label
    }()
    var textFieldEstado : UITextField = {
        let textField = UITextField()
        textField.placeholder = "UF"
        textField.font = UIFont.systemFont(ofSize: Constants.screenHeight*4/100)
        textField.tag = 0
        textField.addTarget(self, action: #selector(pegaDados(_ :)), for: .editingChanged)
        return textField
    }()
    @objc func pegaDados(_ sender:UITextField) {
        delegate?.pegaDadosDoTextField(textField: sender)
    }
    var buttonSearch : UIButton = {
        let button = UIButton()
        button.setButtonWithImage(named: "search2", radius: 15)
        button.addTarget(self, action: #selector(requestToAPI(_ :)), for: .touchUpInside)
        return button
    }()
    @objc func requestToAPI(_ sender:UIButton) {
        delegate?.requestToAPI()
    }
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.backgroundColor = UIColor.red.cgColor
        return tableView
    }()
    
    var animationView = AnimationView(name: "5668-loadder")
    
    
}




//MARK: - PROTOCOLO DO CODEVIEW
extension EnderecoViewControllerScreen : ViewCode {
    
    //Adicionar View
    func buildViewHierarchy() {
        addSubview(view)
        addSubview(view2)
        addSubview(labelVoltar)
        addSubview(buttonToBack)
        addSubview(labelCidadeUser)
        addSubview(textFieldCidade)
        addSubview(lineView)
        addSubview(labelLogradouroUser)
        addSubview(textFieldLogradouro)
        addSubview(lineView2)
        addSubview(labelEstadoUser)
        addSubview(textFieldEstado)
        addSubview(lineView3)
        addSubview(buttonSearch)
        addSubview(tableView)
        addSubview(animationView)
    }
    
    //Configurar Constraints
    func setupContraints() {
        
        //Iphone SE
        let margin = Constants.screenWidth * 0.03 // 10
        let distTextToLabel = Constants.screenHeight * 0.0135 // 7.5
        let distLineToText = Constants.screenHeight * 0.0045 // 2.5
        let distLabelToLine = Constants.screenHeight * 0.027 // 15
        //        let distBottomThroughLastComponente = Constants.screenHeight * 0.072 // 40
        
        view.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constants.viewHeight)
        }
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom).offset(0)
            make.right.left.equalToSuperview()
            make.height.equalTo(Constants.viewHeight*1.5)
        }
        buttonToBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalTo(view2)
            make.height.width.equalTo(45)
        }
        labelVoltar.snp.makeConstraints { (make) in
            make.left.equalTo(buttonToBack.snp.right).offset(0)
            make.centerY.equalTo(view2)
        }
        labelCidadeUser.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom).offset(Constants.screenWidth * 2/100)
            make.left.equalToSuperview().offset(margin)
        }
        textFieldCidade.snp.makeConstraints { (make) in
            make.top.equalTo(labelCidadeUser.snp.bottom).offset(distTextToLabel)
            make.left.equalToSuperview().offset(margin)
            make.right.equalTo(lineView.snp.right).offset(0)
            make.height.equalTo(Constants.screenHeight*4/100)
        }
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldCidade.snp.bottom).offset(distLineToText)
            make.left.equalTo(textFieldCidade.snp.left).offset(0)
            make.right.equalToSuperview().offset(-60)
        }
        
        labelLogradouroUser.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(distLabelToLine)
            make.left.equalToSuperview().offset(margin)
        }
        textFieldLogradouro.snp.makeConstraints { (make) in
            make.top.equalTo(labelLogradouroUser.snp.bottom).offset(distTextToLabel)
            make.left.equalToSuperview().offset(margin)
            make.right.equalTo(lineView2.snp.right).offset(0)
            make.height.equalTo(Constants.screenHeight*4/100)
        }
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldLogradouro.snp.bottom).offset(distLineToText)
            make.left.equalTo(textFieldLogradouro.snp.left).offset(0)
            make.right.equalTo(lineView3.snp.left).offset(0)
        }
        
        labelEstadoUser.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom).offset(Constants.screenWidth * 2/100)
            make.left.equalTo(textFieldEstado.snp.left).offset(0)
        }
        textFieldEstado.snp.makeConstraints { (make) in
            make.top.equalTo(labelEstadoUser.snp.bottom).offset(distTextToLabel)
            make.right.equalToSuperview().offset(-margin)
            make.right.equalTo(lineView3.snp.right).offset(0)
            make.height.equalTo(Constants.screenHeight*4/100)
        }
        lineView3.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldEstado.snp.bottom).offset(distLineToText)
            make.left.equalTo(textFieldEstado.snp.left).offset(0)
            make.right.equalToSuperview().offset(-10)
        }
        
        buttonSearch.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineView2.snp.bottom).offset(0)
            make.right.equalToSuperview().offset(-Constants.screenWidth*0.005)
            make.height.width.equalTo(50)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonSearch.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(0)
        }
        animationView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
    }
    
    //SetupAdditional
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
