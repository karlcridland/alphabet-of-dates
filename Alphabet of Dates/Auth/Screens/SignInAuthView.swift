//
//  SignInAuthView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class SignInAuthView: AuthSubview {
    
    let email, password: AuthTextField
    let recovery: AuthRecoverButton
    
    init() {
        self.email = AuthEmailField()
        self.password = AuthPasswordField()
        self.recovery = AuthRecoverButton()
        super.init(type: .signIn)
        self.placeToScroll([self.email, self.password, self.recovery])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
