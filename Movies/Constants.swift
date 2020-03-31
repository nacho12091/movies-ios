//
//  Constants.swift
//  Movies
//
//  Created by Ignacio Lima on 9/19/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

struct Constants {
    
    // MARK: - Segues string constants
    struct segues {
        static let showMovieDetail = "showMovieDetail"
        static let showMovieFacts = "showMovieFacts"
        static let showCastAndCrew = "showCastAndCrew"
        static let showRateItScreen = "showRateItScreen"
        static let showRateImageScreen = "showRateImageScreen"
        static let showReadMoreMovie = "showReadMoreMovie"
        static let showPersonDetails = "showPersonDetails"
        static let showPersonFacts = "showPersonFacts"
        static let showKnownForInfo = "showKnownForInfo"
        static let showReadMorePerson = "showReadMorePerson"
    }
    
    struct cellIdentifiers {
        static let castAndCrewCell = "CastAndCrewCell"
        static let movieCell = "MovieCell"
        static let personCell = "PersonCell"
    }
    
    struct dateFormats {
        static let first = "MMMM dd, yyyy"
        static let second = "yyyy-MM-dd"
    }
    
    struct links {
        static let imageBaseLink = "https://image.tmdb.org/t/p/original"
    }
    
    struct parameters {
        static let apiKey = "api_key"
        static let sessionId = "session_id"
        static let requestToken = "request_token"
    }
    
    struct general {
        static let apiKey = "f5b6abcb07a14d121bdd075f9134a831"
    }
    
    struct messages {
        static let loginToAccessSettings = "Log in to access your account settings."
        static let loginToRateMovie = "Log in to rate this movie."
    }
}
