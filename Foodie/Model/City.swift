//
//  City.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
}

struct SearchResult: Codable {
    let locations: [City]
    
    enum CodingKeys: String, CodingKey {
        case locations = "location_suggestions"
    }
}
