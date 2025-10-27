//
//  Authentication.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 27/10/2025.
//

protocol Authentication {
    
    var name: String? { get }
    var isSignedIn: Bool { get }
    
    func signIn() throws
    func signOut() throws
    func update(name: String) throws
    
}
