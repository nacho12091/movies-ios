//
//  Account.swift
//  Movies
//
//  Created by Ignacio Lima on 8/27/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class Account: NSObject {
    
    private struct arrayKeys {
        static let id = "id"
        static let name = "name"
        static let username = "username"
    }

    var userId: Int
    var name: String
    var userName: String
    
    init(json: [String : Any]) {
        self.userId = (json[arrayKeys.id] as? Int ?? 0)
        self.name = (json[arrayKeys.name] as? String ?? "")
        self.userName = (json[arrayKeys.username] as? String ?? "")
    }
}
