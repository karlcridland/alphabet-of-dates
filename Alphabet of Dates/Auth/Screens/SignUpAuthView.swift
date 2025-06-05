//
//  SignUpAuthView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class SignUpAuthView: AuthSubview {
    
    let back: AuthSignInButton = AuthSignInButton()
    
    let email: AuthTextField = AuthEmailField()
    let first: AuthFirstNameField = AuthFirstNameField()
    let last: AuthLastNameField = AuthLastNameField()
    let password: AuthNewPasswordField = AuthNewPasswordField()
    let confirm: AuthConfirmPasswordField = AuthConfirmPasswordField()
    
    init() {
        super.init(type: .signUp)
        self.placeToScroll([self.email, self.first, self.last, self.password, self.confirm, self.error, self.back])
    }
    
    override var fields: [AuthTextField] {
        return [self.email, self.first, self.last, self.password, self.confirm]
    }
    
    override func clicked() {
        super.clicked()
        if let email = self.email.value, !email.isEmpty,
           let first = self.first.value, !first.isEmpty,
           let last = self.last.value, !last.isEmpty,
           let password = self.password.value, !password.isEmpty,
           let confirm = self.confirm.value, !confirm.isEmpty {
            if allFieldsValid() {
                let name = Name(first: first, last: last)
                Authentication.shared.signUp(email: email, password: password, name: name) { errorMessage in
                    self.error.text = errorMessage
                    self.enable()
                }
            }
            else {
                self.enable()
            }
        }
        else {
            self.error.text = "Fill in all fields to continue."
            self.enable()
        }
    }
    
    override func allFieldsValid() -> Bool {
        if (super.allFieldsValid()) {
            if (!self.passwordsMatch) {
                self.error.text = "Passwords do not match."
            }
            else {
                return true
            }
        }
        return false
    }
    
    var passwordsMatch: Bool {
        return self.password.value == self.confirm.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
