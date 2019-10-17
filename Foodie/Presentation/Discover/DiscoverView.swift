//
//  DiscoverView.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

class DiscoverView: ControllerView {
    
    lazy private var noResultsLabel = UILabel(font: .bold, text: "No restaurants found in the specified city", fontSize: 23, textColor: .darkGray, textAlignment: .center)
    
    override init() {
        super.init()
        noResultsLabel.alpha = 0
        addSubviews([noResultsLabel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setupUI() {
        noResultsLabel.pin
            .center()
            .width(80%)
            .sizeToFit(.width)
    }
    
    func showNoResultsLabel() {
        UIView.animate(withDuration: 0.3) {
            self.noResultsLabel.alpha = 1
        }
    }
}
