//
//  ActivityManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//




class ActivityManager {
    
    var all: [String: Activity] = [:]
    
    func getActivities(_ id: String, onComplete: @escaping () -> Void) {
        String.alphabet.forEach { char in
            DatabaseManager.shared.getData(for: char, with: id) { data in
                self.all[char] = Activity(data ?? DateData(character: char, [:], id: id))
                if (self.all.keys.count == 26) {
                    onComplete()
                }
            }
        }
    }
    
}