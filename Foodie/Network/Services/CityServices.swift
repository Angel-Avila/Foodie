//
//  CityServices.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

protocol CityServices {
    func getCity(query: String, completion: @escaping (Result<City>) -> Void)
}

class FoodieCityServices: CityServices {
    
    private let modelRepository: ModelRepository<SearchResult>
    
    init(networkClient: NetworkClient = FoodieNetworkClient()) {
        let networkService: (client: NetworkClient, requestBuilder: RequestBuilder) = (client: networkClient, requestBuilder: FoodieRequestBuilder(baseURL: FoodieAPI.apiURL))
        modelRepository = ModelRepository<SearchResult>(networkService: networkService)
    }
    
    func getCity(query: String, completion: @escaping (Result<City>) -> Void) {
        let route = CommonAPI.cities(name: query)
        
        modelRepository.get(route) { result in

            switch result {
            case .success(let searchResult):
                if let city = searchResult.locations.first {
                    completion(.success(city))
                } else {
                    completion(.failure(NSError(domain: "NotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "The specified city \"\(query)\" couldn't be found"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
