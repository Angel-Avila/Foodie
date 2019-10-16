//
//  ControllerView.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

protocol View: UIView {
    func addSubviews(_ views: [UIView])
    func setupUI()
}

class ControllerView: UIView, View {

    init() {
        super.init(frame: .zero)
        backgroundColor = .almostWhiteBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    /// You can add the views by sending the view array here
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    /// Set the frames of your subviews inside this overrided mehtod since it will be called every time `layoutSubviews` is called
    func setupUI() {
        
    }
}
