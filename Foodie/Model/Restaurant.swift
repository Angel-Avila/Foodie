//
//  Restaurant.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let cuisines: String
    let timings: String
    let priceRange: Int
    let aggregateRating: String
    let ratingText: String
    let ratingColor: String
    let votes: String
    
    enum CodingKeys: String, CodingKey {
        case restaurant = "restaurant"
        case name = "name"
        case location = "location"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
        case cuisines = "cuisines"
        case timings = "timings"
        case priceRange = "price_range"
        case userRating = "user_rating"
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case votes = "votes"
    }
    
    init(from decoder: Decoder) throws {
        let upperContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        let container = try upperContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .restaurant)
        
        self.name = try container.decode(String?.self, forKey: .name) ?? "No name"
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        
        self.address = try locationContainer.decode(String?.self, forKey: .address) ?? "-"
        
        if let latitudeString = try locationContainer.decode(String?.self, forKey: .latitude),
            let latitude = Double(latitudeString) {
            self.latitude = latitude
        } else {
            self.latitude = 0
        }
        
        if let longitudeString = try locationContainer.decode(String?.self, forKey: .longitude),
            let longitude = Double(longitudeString) {
            self.longitude = longitude
        } else {
            self.longitude = 0
        }

        self.cuisines = try container.decode(String?.self, forKey: .cuisines) ?? "Unspecified cuisine"
        		
        self.timings = try container.decode(String?.self, forKey: .timings) ?? "-"
        
        self.priceRange = try container.decode(Int?.self, forKey: .priceRange) ?? -1
        
        let ratingContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userRating)
        
        self.aggregateRating = try ratingContainer.decode(String?.self, forKey: .aggregateRating) ?? "-"
        self.ratingText = try ratingContainer.decode(String?.self, forKey: .ratingText) ?? ""
        
        self.ratingColor = try ratingContainer.decode(String?.self, forKey: .ratingColor) ?? ""
        
        self.votes = try ratingContainer.decode(String?.self, forKey: .votes) ?? "0"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        
        var locationContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        
        try locationContainer.encode(self.address, forKey: .address)
        try locationContainer.encode(self.latitude, forKey: .latitude)
        try locationContainer.encode(self.longitude, forKey: .longitude)
        
        try container.encode(self.cuisines, forKey: .cuisines)
        try container.encode(self.timings, forKey: .timings)
        try container.encode(self.priceRange, forKey: .priceRange)
        
        var ratingContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .userRating)
        
        try ratingContainer.encode(self.aggregateRating, forKey: .aggregateRating)
        try ratingContainer.encode(self.ratingText, forKey: .ratingText)
        try ratingContainer.encode(self.ratingColor, forKey: .ratingColor)
        try ratingContainer.encode(self.votes, forKey: .votes)
    }
}


struct RestaurantSearchResults: Codable {
    let restaurants: [Restaurant]
    let resultsFound: Int
    let resultsStart: Int
    let resultsShown: Int
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "restaurants"
        case resultsFound = "results_found"
        case resultsStart = "results_start"
        case resultsShown = "results_shown"
    }
}
