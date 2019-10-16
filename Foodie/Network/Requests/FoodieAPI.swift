//
//  FoodieAPI.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

/// A model describing the API interaction.
public struct FoodieAPI {
    
    private static let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    
    /// API's url.
    static var apiURL: URL = {
        return URL(string: FoodieAPI.baseURLString)!
    }()
    
    static var apiURLString: String = {
        return FoodieAPI.baseURLString
    }()
}
