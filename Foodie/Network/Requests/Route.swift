//
//  Route.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Alamofire

protocol Route {
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var multipart: ((MultipartFormData) -> Void)? { get }
    var extraHeaders: [String: String]? { get }
    var parameterEncoding: ParameterEncoding {get}
    var httpBody: Data? { get }
}

extension Route {
    var extraHeaders: [String: String]? {
        return nil
    }
    var multipart: ((MultipartFormData) -> Void)?{
        return nil
    }
    
    var httpBody: Data? {
        return nil
    }
}
