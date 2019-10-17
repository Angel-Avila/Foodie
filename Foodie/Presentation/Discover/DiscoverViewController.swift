//
//  DiscoverViewController.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class DiscoverViewController: ViewController<DiscoverView> {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .veryLightGray
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let city: City
    private let service: RestaurantServices
    private var restaurants: [Restaurant]
    
    init(city: City, service: RestaurantServices, restaurants: [Restaurant]) {
        self.city = city
        self.service = service
        self.restaurants = restaurants
        super.init(showsNavBar: true, title: city.name)
        controllerView = DiscoverView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        controllerView.pin.all()
        collectionView.pin.all()
    }
    
    private func setupCollectionView() {
        controllerView.addSubview(collectionView)
        controllerView.setNeedsLayout()
        
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: String(describing: RestaurantCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
        
        if restaurants.count == 0 {
            collectionView.alpha = 0
            controllerView.showNoResultsLabel()
        }
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = restaurants[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RestaurantCell.self), for: indexPath) as! RestaurantCell
        
        cell.item = item
        cell.setNeedsLayout()
        
        return cell
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: RestaurantCell.preferredHeight)
    }
}
