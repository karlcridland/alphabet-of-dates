//
//  SignInAuthView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class SignInAuthView: AuthSubview {
    
    let email: AuthTextField = AuthEmailField()
    let password: AuthTextField = AuthPasswordField()
    let recovery: AuthRecoverButton = AuthRecoverButton()
    let signUp: AuthRegisterButton = AuthRegisterButton()
    let separator: AuthSeparatorView = AuthSeparatorView()
    let signUpLabel: AuthSignUpLabel = AuthSignUpLabel()
    
    init() {
        super.init(type: .signIn)
        self.placeToScroll([self.email, self.password, self.error, self.recovery, self.separator, self.signUpLabel, self.signUp])
    }
    
    override func clicked() {
        super.clicked()
        if let email = self.email.value, !email.isEmpty,
           let password = self.password.value, !password.isEmpty {
            if allFieldsValid() {
                Authentication.shared.signIn(email: email, password: password) { errorMessage in
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
    
    override var fields: [AuthTextField] {
        return [self.email, self.password]
    }
    
    @objc func recover() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
