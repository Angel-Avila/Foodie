//
//  SearchView.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

class SearchView: ControllerView {
    
    lazy private var searchTextField: UITextField = {
        let textField = TextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.font = UIFont.regular.withSize(25)
        textField.placeholder = "e.G. San Francisco"
        textField.textColor = .darkGray
        textField.tintColor = .main
        return textField
    }()
    
    lazy private var useLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Icon.location.image, for: .normal)
        button.backgroundColor = .main
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.float(shadowColor: .main)
        return button
    }()
    
    lazy private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.demiBold.withSize(22)
        button.backgroundColor = .main
        button.layer.cornerRadius = DesignConstants.searchButtonSize.height / 2
        button.float(shadowColor: .main)
        return button
    }()
    
    var query: String {
        return searchTextField.text ?? ""
    }
    
    func addSearchButtonTarget(target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        searchButton.addTarget(target, action: action, for: controlEvent)
    }
    
    override init() {
        super.init()
        addSubviews([searchTextField, useLocationButton, searchButton])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setupUI() {
        useLocationButton.pin
            .right(DesignConstants.horizontalMargin)
            .vCenter(-100)
            .size(DesignConstants.locationButtonSize)
        
        searchTextField.pin
            .left(DesignConstants.horizontalMargin)
            .right(to: useLocationButton.edge.left)
            .vCenter(to: useLocationButton.edge.vCenter)
            .height(DesignConstants.textFieldHeight)
            .marginRight(DesignConstants.horizontalPadding)
        
        searchButton.pin
            .below(of: searchTextField)
            .hCenter()
            .size(DesignConstants.searchButtonSize)
            .marginTop(DesignConstants.verticalPadding)
    }
}

private extension SearchView {
    enum DesignConstants {
        static let horizontalMargin: CGFloat = 20
        static let horizontalPadding: CGFloat = 8
        static let verticalPadding: CGFloat = 30
        static let textFieldHeight: CGFloat = 40
        static let locationButtonSize: CGSize = CGSize(width: 40, height: 40)
        static let searchButtonSize: CGSize = CGSize(width: 220, height: 60)
    }
}
