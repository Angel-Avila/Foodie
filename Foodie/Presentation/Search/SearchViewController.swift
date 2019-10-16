//
//  SearchViewController.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class SearchViewController: ViewController<SearchView> {
    
    private let cityServices: CityServices
    private let restaurantServices: RestaurantServices
    
    init(cityServices: CityServices, restaurantServices: RestaurantServices) {
        self.cityServices = cityServices
        self.restaurantServices = restaurantServices
        super.init(showsNavBar: true, title: "Foodie")
        controllerView = SearchView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        controllerView.addSearchButtonTarget(target: self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    @objc private func searchButtonPressed() {
        cityServices.getCity(query: controllerView.query) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .success(let city):
                strongSelf.getRestaurants(forCity: city)
                
            case .failure(let error):
                print("City search failure:", error)
            }
            
        }
    }
    
    private func getRestaurants(forCity city: City) {
        restaurantServices.getRestaurants(cityId: city.id) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .success(let restaurants):
                let navigator = strongSelf.getNavigator()
                navigator?.setBackButtonItemTitle(to: "")
                navigator?.navigate(.push(view: .discover(city: city, restaurants: restaurants)), strongSelf)
            
            case .failure(let error):
                print("Restaurant search failure:", error)
                
            }
        }
    }
}
