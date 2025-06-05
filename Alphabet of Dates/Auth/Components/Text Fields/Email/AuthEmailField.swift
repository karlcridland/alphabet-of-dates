//
//  AuthEmailField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthEmailField: AuthTextField {
    
    init() {
        super.init("Email Address", .emailAddress)
        self.errorMessage = "Invalid email address."
    }
    
    override var isValid: Bool {
        return super.isValid && self.value?.isValidEmpty ?? false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
