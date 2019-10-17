//
//  RestaurantAPI.swift
//  Foodie
//
//  Created by Angel Avila on 10/16/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

public enum RestaurantAPI {
    case restaurants(byCityId: Int)
}

extension RestaurantAPI: Route {
    var path: String {
        switch self {
        case .restaurants:
            return "/search"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .restaurants(let id):
            return ["entity_id": String(id) as AnyObject,
                    "entity_type": "city" as AnyObject,
                    "count": "20" as AnyObject,
                    "radius": "5000" as AnyObject,
                    "sort": "rating" as AnyObject,
                    "order": "desc" as AnyObject]
        }
    }
    
    var parameterEncoding: ParameterEncoding{
        return URLEncoding.default
    }
}
