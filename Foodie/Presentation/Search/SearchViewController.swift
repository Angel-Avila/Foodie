//
//  SearchViewController.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class SearchViewController: ViewController<SearchView> {
    
    private let service: CityServices
    
    init(service: CityServices) {
        self.service = service
        super.init(showsNavBar: true, title: "Foodie")
        controllerView = SearchView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        controllerView.addSearchButtonTarget(target: self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    @objc private func searchButtonPressed() {
        service.getCity(query: controllerView.query) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
                
            case .success(let city):
                let navigator = strongSelf.getNavigator()
                navigator?.setBackButtonItemTitle(to: "")
                navigator?.navigate(.push(view: .discover(city: city)), strongSelf)
                
            case .failure(let error):
                print("Failure:", error)
            }
            
        }
    }
}
