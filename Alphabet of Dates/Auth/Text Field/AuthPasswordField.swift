//
//  AuthPasswordField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthPasswordField: AuthTextField {
    
    override init(_ placeholder: String = "Password", _ textContentType: UITextContentType = .password) {
        super.init(placeholder, textContentType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class AuthNewPasswordField: AuthPasswordField {
    
    init() {
        super.init("Password", .newPassword)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class AuthConfirmPasswordField: AuthPasswordField {
    
    init() {
        super.init("Confirm Password", .password)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
