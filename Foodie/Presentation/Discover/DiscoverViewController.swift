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
    private let service: RestaurantServices
    private var restaurants: [Restaurant]
    
    init(city: City, service: RestaurantServices, restaurants: [Restaurant]) {
        self.city = city
        self.service = service
        self.restaurants = restaurants
        super.init(showsNavBar: true, title: city.name)
        controllerView = DiscoverView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        restaurants.forEach { print("\($0.name), \($0.cuisines), Rating: \($0.aggregateRating)⭐") }
    }
}
