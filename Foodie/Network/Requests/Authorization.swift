//
//  Authorization.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

class Authorization {
    
    private struct AuthorizationPlist: Codable {
        let key: String
    }
    
    private static var key: String = {
        let path = Bundle.main.path(forResource: "Authorization", ofType: "plist")
        let xml = FileManager.default.contents(atPath: path ?? "")
        let plist = try? PropertyListDecoder().decode(AuthorizationPlist.self, from: xml ?? Data())
        return plist?.key ?? ""
    }()
    
    class var header: [String: String]? {
        return [
            "user-key": key
        ]
    }
}
