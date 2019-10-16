//
//  RequestBuilder.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Alamofire
import Foundation

/// An interface to generate the URLRequests for the Network Client.
protocol RequestBuilder {
    
    /// Creates a URLRequest with the given route.
    ///
    /// - Parameter route: The route desribing the request.
    /// - Returns: The URLRequest that satisfies the given route.
    func request(for route: Route) -> URLRequest
}

/// The base implementation for RequestBuilder protocol.
final class FoodieRequestBuilder: RequestBuilder {
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func request(for route: Route) -> URLRequest {
        let url = baseURL.appendingPathComponent(route.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = route.parameters?.compactMap { URLQueryItem(name: $0.key, value: ($0.value as? String) ?? "") }
        
        guard let requestURL = components?.url else {
            assertionFailure("Unable to create URL from route: \(route)")
            return URLRequest(url: url)
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: requestURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 20.0)
        request.httpMethod = route.method.rawValue
        request.allHTTPHeaderFields = Authorization.header
        request.httpBody = route.httpBody
        
        return request as URLRequest
    }
}

