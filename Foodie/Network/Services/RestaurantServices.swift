//
//  RestaurantServices.swift
//  Foodie
//
//  Created by Angel Avila on 10/16/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation
import Alamofire

protocol RestaurantServices {
    func getRestaurants(cityId: Int, completion: @escaping (Result<[Restaurant]>) -> Void)
}

class FoodieRestaurantServices: RestaurantServices {
    
    private let modelRepository: ModelRepository<RestaurantSearchResults>
    
    init(networkClient: NetworkClient = FoodieNetworkClient()) {
        let networkService: (client: NetworkClient, requestBuilder: RequestBuilder) = (client: networkClient, requestBuilder: FoodieRequestBuilder(baseURL: FoodieAPI.apiURL))
        modelRepository = ModelRepository<RestaurantSearchResults>(networkService: networkService)
    }
    
    func getRestaurants(cityId: Int, completion: @escaping (Result<[Restaurant]>) -> Void) {
        let route = RestaurantAPI.restaurants(byCityId: cityId)
        
        modelRepository.get(route) { result in
            
            switch result {
            case .success(let searchResult):
                completion(.success(searchResult.restaurants))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
