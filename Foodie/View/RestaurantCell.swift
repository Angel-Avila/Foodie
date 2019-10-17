//
//  RestaurantCell.swift
//  Foodie
//
//  Created by Angel Avila on 10/16/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    var item: Restaurant? {
        didSet {
            guard let restaurant = item else { return }
            
            nameLabel.text = restaurant.name
            ratingLabel.text = restaurant.aggregateRating
            votesLabel.text = restaurant.votes
            cuisineLabel.text = restaurant.cuisines
            priceRangeLabel.text = restaurant.priceRange
            
            imageView.setImage(from: restaurant.thumbnail)
        }
    }
    
    static var preferredHeight: CGFloat {
        return DesignConstants.imageViewSize.height + DesignConstants.verticalMargin * 2
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var nameLabel = UILabel(font: .bold, text: "", fontSize: 23, textColor: .darkText, textAlignment: .left)
    
    lazy private var cuisineLabel = UILabel(font: .regular, text: "", fontSize: 17, textColor: .gray, textAlignment: .left)
    
    lazy private var priceRangeLabel = UILabel(font: .bold, text: "", fontSize: 21, textColor: .darkGray, textAlignment: .left)
    
    lazy private var ratingLabel = UILabel(font: .demiBold, text: "", fontSize: 21, textColor: .darkGray, textAlignment: .left)
    
    lazy private var votesLabel = UILabel(font: .regular, text: "", fontSize: 15, textColor: .gray, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        nameLabel.numberOfLines = 1
        
        [imageView, nameLabel, ratingLabel, votesLabel, cuisineLabel, priceRangeLabel].forEach { addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    private func setupUI() {
        imageView.pin
            .left(DesignConstants.horizontalMargin)
            .top(DesignConstants.verticalMargin)
            .size(DesignConstants.imageViewSize)
        
        nameLabel.pin
            .after(of: imageView)
            .right(DesignConstants.horizontalMargin)
            .top(to: imageView.edge.top)
            .marginLeft(DesignConstants.horizontalPadding)
            .sizeToFit(.width)
        
        cuisineLabel.pin
            .vCenter(to: imageView.edge.vCenter)
            .left(to: nameLabel.edge.left)
            .right(DesignConstants.horizontalMargin)
            .sizeToFit(.width)
        
        priceRangeLabel.pin
            .bottom(to: imageView.edge.bottom)
            .left(to: nameLabel.edge.left)
            .height(22)
            .marginTop(DesignConstants.verticalPadding)
            .sizeToFit(.height)
        
        ratingLabel.pin
            .left(to: priceRangeLabel.edge.right)
            .vCenter(to: priceRangeLabel.edge.vCenter)
            .height(of: priceRangeLabel)
            .sizeToFit(.height)
        
        votesLabel.pin
            .left(to: ratingLabel.edge.right)
            .vCenter(to: priceRangeLabel.edge.vCenter)
            .height(of: priceRangeLabel)
            .sizeToFit(.height)
    }
}


private extension RestaurantCell {
    enum DesignConstants {
        static let horizontalMargin: CGFloat = 20
        static let horizontalPadding: CGFloat = 30
        static let verticalMargin: CGFloat = 20
        static let verticalPadding: CGFloat = 12
        static let imageViewSize: CGSize = CGSize(width: 106, height: 106)
    }
}
