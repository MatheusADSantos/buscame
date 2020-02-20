//
//  BookmarkViewControllerScreen.swift
//  Buscame
//
//  Created by macbook-estagio on 28/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

final class BookmarkViewControllerScreen : UIView, UISearchBarDelegate {
    
    weak var delegate : BookmarkViewDelegate?
    
    var frameTableView: CGRect {
        let width = Constants.screenWidth
        let height = Constants.screenHeight
        return CGRect( x: 10, y: (Constants.screenHeight * 0.2), width: (width - 20), height: (height - 0.2 * Constants.screenHeight) )
    }
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        
        static let viewHeight = Constants.screenHeight*0.04
        static let margin = Constants.screenWidth*0.05
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setupTableView()
        searchBar.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTableView() {
        tableView = UITableView(frame: frameTableView)
        self.addSubview(tableView)
    }
    
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
        button.addTarget(self, action: #selector(backScreen(_:)), for: .touchUpInside)
        return button
    }()
    @objc func backScreen(_ sender:Any) {
        delegate?.backScreen()
    }
    var searchBar : UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .black
        search.placeholder = "Busque pela cidade favorita!"
        search.tintColor = .blue
        return search
    }()
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.backgroundColor = UIColor.red.cgColor
        tableView.layer.borderWidth = 2
        return tableView
    }()
    
}

extension BookmarkViewControllerScreen : ViewCode {
    
    //ADICIONANDO AS VIEWS
    func buildViewHierarchy() {
        addSubview(view)
        addSubview(view2)
        addSubview(buttonToBack)
        addSubview(searchBar)
        addSubview(tableView)
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
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom).offset(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    //SETUPADDITIONAL
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

