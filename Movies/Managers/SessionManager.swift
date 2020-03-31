//
//  SessionManager.swift
//  Movies
//
//  Created by Ignacio Lima on 8/28/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SessionManager: NSObject {
    
    private struct sessionKeys {
        static let sessionId = Constants.parameters.sessionId
    }
    
    static func saveSession(sessionId: String) {
        KeychainWrapper.standard.set(sessionId, forKey: sessionKeys.sessionId)
    }
    
    static func getSessionId() -> String {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: sessionKeys.sessionId)
        return retrievedString ?? ""
    }
    
    static func clearSession() {
        KeychainWrapper.standard.removeObject(forKey: sessionKeys.sessionId)
    }
    
    static func isLogged() -> Bool {
        return ((KeychainWrapper.standard.string(forKey: sessionKeys.sessionId) != nil))
    }

}
