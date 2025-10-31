//
//  ActivityViewSelection.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 31/10/2025.
//

enum ActivityViewSelection: String, CaseIterable {
    
    case letter = "View Letter"
    case image = "Cover Image"
    case info = "Informative"
    
    var systemImage: String {
        switch self {
            case .letter: return "character.circle"
            case .image: return "photo"
            case .info: return "checkmark.circle.badge.plus"
        }
    }
    
}
