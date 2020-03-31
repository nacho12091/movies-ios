//
//  Person.swift
//  Movies
//
//  Created by Ignacio Lima on 8/1/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    private struct arrayKeys {
        static let personId = "id"
        static let personName = "name"
        static let personProfile = "profile_path"
        static let knownFor = "known_for"
        static let mediaType = "media_type"
        static let movieTitle = "title"
        static let tvShow = "name"
        static let movie = "movie"
        static let tv = "tv"
    }
    
    var personId: Int
    var personName:  String
    var personDescription: String
    var personPhoto: String
    var knownFor: String
    var knownForDepartment: String
    var gender: Int
    var birthday: String
    var placeOfBirth: String
    var popularity: Int

    init(json: [String: Any]) {
        let knFor = (json )[arrayKeys.knownFor] as Any
        var knForText = ""
        var index = 0        
        while index < (knFor as! [Any]).count {
            for item in knFor as! [Any] {
                if(index == 0) {
                    if((item as! [String: Any])[arrayKeys.mediaType] as! String == arrayKeys.movie) {
                        let movieTitle: String = (item as! [String: Any])[arrayKeys.movieTitle] as! String
                        knForText = knForText + " " + movieTitle
                    } else if((item as! [String: Any])[arrayKeys.mediaType] as! String == arrayKeys.tv) {
                        let tvProgName: String = (item as! [String: Any])[arrayKeys.tvShow] as! String
                        knForText = knForText + " " + tvProgName
                    }
                } else {
                    if((item as! [String: Any])[arrayKeys.mediaType] as! String == arrayKeys.movie) {
                        let movieTitle: String = (item as! [String: Any])[arrayKeys.movieTitle] as! String
                        knForText = knForText + ", " + movieTitle
                    } else if((item as! [String: Any])[arrayKeys.mediaType] as! String == arrayKeys.tv) {
                        let tvProgName: String = (item as! [String: Any])[arrayKeys.tvShow] as! String
                        knForText = knForText + ", " + tvProgName
                    }
                }
                index += 1
            }
        }
        self.knownFor = knForText
        self.personId = (json[arrayKeys.personId] as? Int ?? 0)
        self.personName = (json[arrayKeys.personName] as? String ?? "")
        self.personDescription = ""
        self.personPhoto = Constants.links.imageBaseLink + (json[arrayKeys.personProfile] as? String ?? "")
        self.gender = 0
        self.birthday = ""
        self.placeOfBirth = ""
        self.popularity = 0
        self.knownForDepartment = ""
    }
    
}
