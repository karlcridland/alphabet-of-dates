//
//  Activity.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 22/10/2025.
//

class Activity: Identifiable, Hashable {
    
    let id: String
    let character: Character
    var title: String?
    
    init(id: String, character: Character, title: String? = nil) {
        self.id = id
        self.character = character
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id && lhs.character == rhs.character
    }
    
}
