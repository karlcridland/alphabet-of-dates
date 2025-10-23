//
//  ActivityManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 23/10/2025.
//

import Foundation

class ActivityManager {
    
    let id: String
    private var activities: Set<Activity> = []
    
    init(_ id: String = UUID().uuidString) {
        self.id = id
        Character.alphabet.forEach(download(character:))
    }
    
    func get(character: Character) -> Activity? {
        return activities.first(where: { $0.character == character })
    }
    
    private func download(character: Character) {
        #warning("TODO: Download activity details from database.")
    }
    
}

extension Character {
    
    static var alphabet: Array<Character> {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(separator: "").map({String($0).first!})
    }
    
}
