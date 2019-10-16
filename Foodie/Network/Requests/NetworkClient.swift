//
//  NetworkClient.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

/// A protocol that defines how to interact with an object capable to hanle network requests.
protocol NetworkClient {
    
    /// Sends a network request with the specified information and returns a token for cancelation.
    ///
    /// - Parameters:
    ///   - request: An URL request to execute.
    ///   - completion: A closure with Result object with Data associated type.
    /// - Returns: A token for cancelation.
    @discardableResult
    func execute(request: URLRequest, completion: @escaping (Result<(Data)>) -> Void) -> CancellableToken
}


/// The base implementation for NetworkClient protocol.
final class FoodieNetworkClient: NetworkClient {
    
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager = .default) {
        self.sessionManager = sessionManager
    }
    
    func execute(request: URLRequest, completion: @escaping (Result<(Data)>) -> Void) -> CancellableToken {
        let dataRequest = sessionManager.request(request)
        dataRequest.responseData() { dataResponse in
            switch dataResponse.result {
            case let .success(data):
                completion(Result.success(data))
            case let .failure(error):
                completion(Result.failure(error))
            }
        }
        
        return CancellableToken(action: { dataRequest.cancel() })
    }
}
