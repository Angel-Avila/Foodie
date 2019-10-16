//
//  DefaultComponentProvider.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

/// An enum that represents where the app should go or which ViewController it should show.
enum NavigationView {
    /// Root view controller of the app
    case root
    
    /// Search view controller to discover restaurants in a specified area
    case search
    
    /// A view controller that displays the restaurants in the specified area
    case discover(city: City, restaurants: [Restaurant])
    
    /// A view controller that displays the details from a selected restaurant
    case restaurantDetail
    
    /// No view controller. Could be used in some cases where navigation shouldn't go there.
    case none
}

class DefaultComponentProvider: ComponentProvider {
    
    let cityService = FoodieCityServices()
    let restaurantService = FoodieRestaurantServices()
    
    /// Returns a `UIViewController` depending on which `NavigationView` enum case you sent.
    ///
    /// - Parameter view: A case from the `NavigationView` enum. It represents a view controller and every new view controller the code should navigate to, should be added to be handled here.
    /// - Returns: The ViewController to be presented/navigated to.
    func resolve(_ view: NavigationView) -> UIViewController {
        switch view {
            
        case .root:
            return SearchViewController(cityServices: cityService, restaurantServices: restaurantService)
            
        case .search:
            return SearchViewController(cityServices: cityService, restaurantServices: restaurantService)
        
        case .discover(let city, let restaurants):
            return DiscoverViewController(city: city, service: restaurantService, restaurants: restaurants)
            
        default:
            return UIViewController(nibName: nil, bundle: nil)
        }
    }
}
