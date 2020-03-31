//
//  CastAndCrew.swift
//  Movies
//
//  Created by Ignacio Lima on 8/13/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class CastAndCrew: NSObject {
    
    private struct arrayKeys {
        static let personGender = "gender"
        static let name = "name"
        static let personImage = "profile_path"
    }

    var personDescription: String
    var personName: String
    var personImageURL: String
    var personGender: Int
    
    init(json: [String: Any], type: String) {
        self.personDescription = (json)[type] as? String ?? ""
        self.personName = (json)[arrayKeys.name] as! String
        self.personGender = (json)[arrayKeys.personGender] as! Int
        if((json)[arrayKeys.personImage] as? String ?? "" != "") {
            self.personImageURL = Constants.links.imageBaseLink + ((json)[arrayKeys.personImage] as! String)
        } else {
            self.personImageURL = ""
        }
    }
}
