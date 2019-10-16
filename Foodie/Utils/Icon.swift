//
//  Icon.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

enum Icon {
    case location
}

extension Icon {
    
    var image: UIImage? {
        switch self {
        case .location:
            return UIImage(named: "location")
        }
    }
}
