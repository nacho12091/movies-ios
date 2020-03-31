//
//  ApiClient.swift
//  Movies
//
//  Created by Ignacio Lima on 7/8/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import Alamofire

class ApiClient: NSObject {
    
    private struct keys {
        static let baseLink = "https://api.themoviedb.org/3"
    }
    
    static func getRequest(endpoint:  String, parameters: [String: Any], completion:@escaping ([String : Any]) -> Void) {
        var params: [String: Any] = [Constants.parameters.apiKey: Constants.general.apiKey]
        for parameter in parameters {
            params[parameter.key] = parameter.value
        }
        let url = String(format: keys.baseLink + "%@", String(endpoint))
        Alamofire.request(url, parameters: params).responseJSON { response in
            if let json = response.result.value as? [String : Any] {
                completion(json)
            }
        }
    }
    
    static func postRequest(endpoint:  String, parameters: [String: Any], completion:@escaping ([String : Any]) -> Void) {
        var url = String(format: keys.baseLink + "%@?" + Constants.parameters.apiKey + "=" + Constants.general.apiKey, String(endpoint))
        url += String(format: "&" + Constants.parameters.sessionId + "=%@", String(SessionManager.getSessionId()))
        let params: Parameters = parameters
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value as? [String : Any] {
                completion(json)
            }
        }
    }
    
    static func deleteRequest(endpoint: String, parameters: [String: Any], movieId: Int, completion:@escaping () -> Void) {
        var params: [String: Any] = [Constants.parameters.apiKey: Constants.general.apiKey]
        for parameter in parameters {
            params[parameter.key] = parameter.value
        }
        let url = String(format: Constants.parameters.apiKey + "%@", String(endpoint))
        Alamofire.request(url, method: .delete, parameters: params).responseJSON { response in
            if (response.result.value as? [String : Any]) != nil {
                completion()
            }
        }
    }
    
}
