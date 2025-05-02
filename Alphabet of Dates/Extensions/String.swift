//
//  String.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 02/05/2025.
//

extension String {
    
    static func generateRandomString(length: Int = 12) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
}
