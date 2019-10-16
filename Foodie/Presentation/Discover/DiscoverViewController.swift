//
//  DiscoverViewController.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class DiscoverViewController: ViewController<DiscoverView> {
    
    private let city: City
    
    init(city: City) {
        self.city = city
        super.init(showsNavBar: true, title: city.name)
        controllerView = DiscoverView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
