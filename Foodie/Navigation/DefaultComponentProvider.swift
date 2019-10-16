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
    case discover(city: City)
    
    /// A view controller that displays the details from a selected restaurant
    case restaurantDetail
    
    /// No view controller. Could be used in some cases where navigation shouldn't go there.
    case none
}

class DefaultComponentProvider: ComponentProvider {
    
    let cityService = FoodieCityServices()
    
    /// Returns a `UIViewController` depending on which `NavigationView` enum case you sent.
    ///
    /// - Parameter view: A case from the `NavigationView` enum. It represents a view controller and every new view controller the code should navigate to, should be added to be handled here.
    /// - Returns: The ViewController to be presented/navigated to.
    func resolve(_ view: NavigationView) -> UIViewController {
        switch view {
            
        case .root:
            return SearchViewController(service: cityService)
            
        case .search:
            return SearchViewController(service: cityService)
        
        case .discover(let city):
            return DiscoverViewController(city: city)
            
        default:
            return UIViewController(nibName: nil, bundle: nil)
        }
    }
}
