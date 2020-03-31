//
//  AccountManager.swift
//  Movies
//
//  Created by Ignacio Lima on 8/27/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class AccountManager: NSObject {

    private struct keys {
        static let token = "request_token"
        static let success = "success"
        static let statusCode = "status_code"
        static let sessionId = "session_id"
        static let paramUsername = "username"
        static let paramPassword = "password"
        static let validateWithLogin = "/authentication/token/validate_with_login"
        static let newSession = "/authentication/session/new"
        static let newToken = "/authentication/token/new"
        static let account = "/account"
    }
    
    static func login(username: String, password: String, completion:@escaping (Bool) -> Void) {
        let getToken = { (json: String) in
            let token = (json)
            let validateLogin = { (json: [String: Any]) in
                var result = false
                if (json[keys.success] != nil) && (json[keys.success] as! Int)  == 1 {
                    let getSessionId = { (json: String) in
                        SessionManager.saveSession(sessionId: json)
                    }
                    AccountManager.validateSessionId(error: false, token: json[keys.token] as! String, completion: getSessionId)
                    result = true
                } else if (json[keys.statusCode] != nil && (json[keys.statusCode] as! Int)  == 30) {
                    result = false
                }

                completion(result)
            }
            let parameters = [keys.paramUsername: username, keys.paramPassword: password, keys.token: token]
            let endpoint = keys.validateWithLogin
            ApiClient.postRequest(endpoint: endpoint, parameters: parameters, completion: validateLogin)
        }
        AccountManager.getAuthorizationToken(completion: getToken)
    }
    
    static func validateSessionId(error: Bool, token: String, completion:@escaping (String) -> Void) {
        if !error {
            let getSession = { (json: [String: Any]) in
                let sessionId = json[keys.sessionId]
                completion(sessionId as? String ?? "")
            }
            let endpoint = keys.newSession
            let parameters = [Constants.parameters.apiKey: Constants.general.apiKey, Constants.parameters.requestToken: token]
            ApiClient.postRequest(endpoint: endpoint, parameters: parameters, completion: getSession)
        }
    }
    
    static func getAuthorizationToken(completion:@escaping (String) -> Void) {
        let getToken = { (json: [String: Any]) in
            completion((json)[keys.token] as? String ?? "")
        }
        let endpoint = keys.newToken
        ApiClient.getRequest(endpoint: endpoint, parameters: [:],completion: getToken)
    }
    
    static func getUserData(completion:@escaping (Account) -> Void) {
        let accountGenerator = { (json: [String : Any]) in
            let user = json
            let account = Account(json: user)
            completion(account)
        }
        
        let endpoint = keys.account
        let parameters = [Constants.parameters.sessionId: SessionManager.getSessionId()]
        ApiClient.getRequest(endpoint: endpoint, parameters: parameters, completion: accountGenerator)
    }
}
