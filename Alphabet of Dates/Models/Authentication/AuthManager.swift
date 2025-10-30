//
//  AuthManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 27/10/2025.
//

class AuthManager: Authentication {
    
    public static let shared = AuthManager()
    
    private init() {
        
    }
    
    var name: String?
    
    var isSignedIn: Bool = false
    
    func signIn() throws {
        #warning("TODO: Implement sign in feature")
    }
    
    func signOut() throws {
        #warning("TODO: Implement sign out feature")
    }
    
    func update(name: Name) throws {
        #warning("TODO: Implement name update feature")
    }
    
}
