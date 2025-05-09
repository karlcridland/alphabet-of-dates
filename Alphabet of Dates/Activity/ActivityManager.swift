//
//  ActivityManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

// Stores all of the activities that can be used between the viewing and editing
// screens. Keeps a consistent and synchronised data system.

class ActivityManager {
    
    static var all: [String: Activity] = [:]
    
    static func getActivities(_ id: String, onComplete: @escaping () -> Void) {
        String.alphabet.forEach { char in
            DatabaseManager.shared.getData(for: char, with: id) { data in
                ActivityManager.all[char] = Activity(data ?? DateData(character: char, [:], id: id))
                if (ActivityManager.all.keys.count == 26) {
                    onComplete()
                }
            }
        }
    }
    
}
