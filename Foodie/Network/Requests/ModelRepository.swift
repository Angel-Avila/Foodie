//
//  ModelRepository.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

/// A Repository for objects of the same type, uses the Network and Cache to request them.
final class ModelRepository<T: Decodable> {
    typealias NetworkService = (client: NetworkClient, requestBuilder: RequestBuilder)
    
    private let requestBuilder: RequestBuilder
    private let networkClient: NetworkClient
    
    private lazy var decoder = {
        return JSONDecoder()
    }()
    
    init(networkService: NetworkService) {
        requestBuilder = networkService.requestBuilder
        networkClient = networkService.client
    }
    
    /// Call to get a Model from a given route.
    ///
    /// - Parameters:
    ///   - route: The route to request the object.
    ///   - completion: The Result of the operation.
    @discardableResult
    func get(_ route: Route, completion: @escaping (Result<T>) -> Void) -> CancellableToken {
        let request = requestBuilder.request(for: route)
        return networkClient.execute(request: request) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(dataValue):
                do {
                    let decodedObject = try strongSelf.decoder.decode(T.self, from: dataValue)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
