//
//  Users.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

enum Users: String {
    
    case emily
    case karl

    var user: User {
        switch self {
        case .emily:
            return User(email: "emilytyler13@googlemail.com", password: "KarlCridland94!")
        case .karl:
            return User(email: "karlcridland@gmail.com", password: "EmilyTyler97!")
        }
    }
    
}

struct User {
    let email, password: String
}
