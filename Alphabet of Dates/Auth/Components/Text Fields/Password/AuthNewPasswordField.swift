//
//  AuthNewPasswordField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthNewPasswordField: AuthPasswordField {
    
    init() {
        super.init("Password", .newPassword)
        self.errorMessage = "Invalid password, needs: 8 letters+, lower, one upper, one digit, one special e.g. !@#$%^&*."
    }
    
    override var isValid: Bool {
        return super.isValid && self.value?.isValidPassword ?? false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
