//
//  PeopleManager.swift
//  Movies
//
//  Created by Ignacio Lima on 8/1/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class PeopleManager: NSObject {
    
    private struct keys {
        static let results = "results"
        static let totalResults = "total_results"
        static let cast = "cast"
        static let crew = "crew"
        static let popular = "/person/popular"
        static let person = "/person/%@"
        static let movieCredits = "/person/%@/movie_credits"
        static let searchPerson = "/search/person"
        static let query = "query"
    }

    static func fetchPeople(completion:@escaping ([Person]) -> Void) {
        let peopleGenerator = { (json: [String : Any]) in
            let people = (json)[keys.results]
            var fetchedPeople: [Person] = []
            for person in people as! [Any] {
                let newPerson = Person(json: person as! [String: Any])
                fetchedPeople.append(newPerson)
            }
            completion(fetchedPeople)
        }
        let endpoint = keys.popular
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: peopleGenerator)
    }
    
    static func getPersonDetails(id: Int, completion:@escaping ([String: Any]) -> Void) {
        let personGet = { (json: [String: Any]) in
            var personDetails = [String: Any]()
            personDetails = json
            completion(personDetails)
        }
        
        let endpoint = String(format: keys.person, String(id))
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: personGet)
        
    }
    
    static func fetchKnownForMovies(userId: Int, completion:@escaping ([Movie]) -> Void ) {
        let moviesGenerator = { (json: [String: Any]) in
            var fetchedMovies: [Movie] = []
            let castList = json[keys.cast]
            let crewList = json[keys.crew]
            
            for cast in castList as! [Any] {
                let newMovie = Movie(json: cast as! [String : Any])
                fetchedMovies.append(newMovie)
            }
            
            for crew in crewList as! [Any] {
                let newMovie = Movie(json: crew as! [String : Any])
                fetchedMovies.append(newMovie)
            }
            
            completion(fetchedMovies)
        }
        let endpoint = String(format: keys.movieCredits, String(userId))
        ApiClient.getRequest(endpoint: endpoint, parameters: [:], completion: moviesGenerator)
    }
    
    static func searchPerson(query: String, completion:@escaping ([Person]) -> Void) {
        let getPeople = { (json: [String: Any]) in
            var fetchedPeople: [Person] = []
            if json[keys.totalResults] as! Int > 0 {
                let people = (json)[keys.results]
                for person in people as! [Any] {
                    let newPerson = Person(json: person as! [String : Any])
                    fetchedPeople.append(newPerson)
                }
            }
            completion(fetchedPeople)
        }
        let endpoint = keys.searchPerson
        let parameters = [keys.query: query]
        
        ApiClient.getRequest(endpoint: endpoint, parameters: parameters, completion: getPeople)
    }
}
