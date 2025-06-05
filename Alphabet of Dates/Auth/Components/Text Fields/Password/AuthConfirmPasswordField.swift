//
//  AuthConfirmPasswordField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthConfirmPasswordField: AuthPasswordField {
    
    init() {
        super.init("Confirm Password", .password)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
