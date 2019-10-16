//
//  CommonAPI.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

public enum CommonAPI {
    case cities(name: String)
}

extension CommonAPI: Route {
    var path: String {
        switch self {
        case .cities:
            return "/cities"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .cities(let name):
            return ["q": name as AnyObject,
                    "count": 1 as AnyObject]
        }
    }
    
    var parameterEncoding: ParameterEncoding{
        return URLEncoding.default
    }
}
