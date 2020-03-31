//
//  MovieManager.swift
//  Movies
//
//  Created by Ignacio Lima on 7/16/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class MovieManager: NSObject {
    
    private struct keys {
        static let results = "results"
        static let cast = "cast"
        static let crew = "crew"
        static let character = "character"
        static let department = "department"
        static let totalResults = "total_results"
        static let rated = "rated"
        static let rateValue = "value"
        static let movie = "/movie/%@"
        static let movieCredits = "/movie/%@/credits"
        static let searchMovie = "/search/movie"
        static let query = "query"
        static let accountStates = "/movie/%@/account_states"
        static let rateMovie = "/movie/%@/rating"
        static let value = "value"
        static let deleteValue = "/movie/%@/rating"
    }
    
    static func fetchMovies(endpoint: String, completion:@escaping ([Movie]) -> Void) {
        let moviesGenerator = { (json: [String : Any]) in
            let movies = (json)[keys.results]
            var fetchedMovies: [Movie] = []
            for movie in movies as! [Any] {
                let newMovie = Movie(json: movie as! [String : Any])
                fetchedMovies.append(newMovie)
            }
            completion(fetchedMovies)
        }
        
        let endpoint = String(format: keys.movie, endpoint)
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: moviesGenerator)
    }
    
    static func getMovieDetails(id: Int, completion:@escaping ([String: Any]) -> Void) {
        let movieGet = { (json: [String: Any]) in
            var movieDetails = 	[String: Any]()
            movieDetails = json
            completion(movieDetails)
        }
        
        let endpoint = String(format: keys.movie, String(id))
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: movieGet)
    }
    
    static func fetchCastAndCrew(isCast: Bool, movieId: Int, completion:@escaping ([CastAndCrew]) -> Void) {
        let castAndCrewGenerator = { (json: [String: Any]) in
            let people = json
            var fetchedCastAndCrew: [CastAndCrew] = []
            
            var responseArray : [Any] = []
            var personDescription : String = ""
            
            if isCast {
                responseArray = people[keys.cast] as! [Any]
                personDescription = keys.character
            } else {
                responseArray = people[keys.crew] as! [Any]
                personDescription = keys.department
            }
            
            for person in responseArray {
                let newCast = CastAndCrew(json: person as! [String: Any], type: personDescription)
                fetchedCastAndCrew.append(newCast)
            }
            
            completion(fetchedCastAndCrew)
        }
        
        let endpoint = String(format: keys.movieCredits, String(movieId))
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: castAndCrewGenerator)
    }
    
    static func searchMovie(query: String, completion:@escaping ([Movie]) -> Void) {
        let getMovies = { (json: [String: Any]) in
            var fetchedMovies: [Movie] = []
            if json[keys.totalResults] as! Int > 0 {
                let movies = (json)[keys.results]
                for movie in movies as! [Any] {
                    let newMovie = Movie(json: movie as! [String : Any])
                    fetchedMovies.append(newMovie)
                }
            }
            completion(fetchedMovies)
        }
        let endpoint = keys.searchMovie
        let parameters = [keys.query: query]

        ApiClient.getRequest(endpoint: endpoint, parameters: parameters, completion: getMovies)
    }
    
    static func getMovieState(movieId: Int, completion:@escaping (Double) -> Void) {
        let getState = { (json: [String: Any]) in
            var value: Double = 0
            if (json[keys.rated] as? [String: Any] != nil) {
                let ratedValue = json[keys.rated] as! [String: Any]
                if ((ratedValue[keys.rateValue]) != nil) {
                    value = ratedValue[keys.rateValue] as! Double
                }
            }
            completion(value)
        }
        let endpoint = String(format: keys.accountStates, String(movieId))
        let parameters = [Constants.parameters.sessionId: SessionManager.getSessionId()]

        ApiClient.getRequest(endpoint: endpoint, parameters: parameters, completion: getState)
    }

    static func postRateValue(movieId: Int, value: Double, completion:@escaping () -> Void) {
        let setRateValue = { (json: [String: Any]) in
            completion()
        }
        let endpoint = String(format: keys.rateMovie, String(movieId))
        let parameters = [keys.value: value] as [String : Any]
        ApiClient.postRequest(endpoint: endpoint, parameters: parameters, completion: setRateValue)
    }
    
    static func deteleRateValue(movieId: Int, completion:@escaping () -> Void) {
        let deleteRateValue = { () in
            completion()
        }
        let endpoint = String(format: keys.deleteValue, String(movieId))
        let parameters = [Constants.parameters.sessionId: SessionManager.getSessionId()]
        ApiClient.deleteRequest(endpoint: endpoint, parameters: parameters, movieId: movieId, completion: deleteRateValue)
    }
    
}
