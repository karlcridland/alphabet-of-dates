//
//  AuthenticationSubmitButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class AuthenticationSubmitButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .sageGreen
        self.update(to: .signIn)
        self.layer.cornerRadius = AuthenticationView.margin
        self.layer.cornerCurve = .continuous
    }
    
    func update(to state: AuthenticationState) {
        self.setTitle(state.rawValue, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum AuthenticationState: String {
    case signIn = "Sign in"
    case signUp = "Create account"
    case forgotPassword = "Reset password"
    case signedIn = ""
}
