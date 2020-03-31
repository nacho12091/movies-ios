//
//  Movie.swift
//  Movies
//
//  Created by Ignacio Lima on 7/2/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class Movie: NSObject {

    private struct keys {
        static let id = "id"
        static let title = "title"
        static let rating = "vote_average"
        static let description = "overview"
        static let releaseDate = "release_date"
        static let status = "status"
        static let originalLanguage = "original_language"
        static let runtime = "runtime"
        static let budget = "budget"
        static let revenue = "revenue"
        static let moviePosterPath = "poster_path"
        static let unknown = "Unknown"
    }
    
    var movieId: Int
    var title: String
    var photo: String
    var rating: Double
    var desc: String
    var releaseDate: String
    var status: String
    var originalLanguage: String
    var runtime: Int
    var budget: Int
    var revenue: Int

    init(json: [String: Any]) {
        self.movieId = (json[keys.id] as? Int ?? 0)
        self.title = (json[keys.title] as? String ?? "")
        self.photo = Constants.links.imageBaseLink + (json[keys.moviePosterPath] as? String ?? "")
        self.rating = (json[keys.rating] as? Double ?? 0)
        self.desc = (json[keys.description] as? String ?? "")
        let rDate = (json[keys.releaseDate] as? String ?? "")
        if rDate != "" {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = Constants.dateFormats.second
            let releaseDate = dateFormatterGet.date(from: rDate)
            self.releaseDate = releaseDate?.changeFormat().toString() ?? ""
        } else {
            self.releaseDate = (keys.unknown)
        }
        self.status = (json[keys.status] as? String ?? "")
        self.originalLanguage = (json[keys.originalLanguage] as? String ?? "")
        self.runtime = (json[keys.runtime] as? Int ?? 0)
        self.budget = (json[keys.budget] as? Int ?? 0)
        self.revenue = (json[keys.revenue] as? Int ?? 0)
    }
    
}
