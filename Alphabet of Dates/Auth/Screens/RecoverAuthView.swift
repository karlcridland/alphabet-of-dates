//
//  RecoverAuthView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class RecoverAuthView: AuthSubview {
    
    let title: AuthErrorMessageView = AuthErrorMessageView()
    let email: AuthTextField = AuthEmailField()
    let back: AuthSignInButton = AuthSignInButton()
    
    init() {
        super.init(type: .recover)
        self.placeToScroll([self.title, self.email, self.error, back])
        [self.title, self.error].forEach { label in
            label.textColor = .charcoal
        }
        self.title.text = "Enter your email address to reset your password."
        self.title.height?.isActive = false
        self.title.numberOfLines = 0
    }
    
    override var fields: [AuthTextField] {
        return [self.email]
    }
    
    override func clicked() {
        super.clicked()
        if let email = self.email.value, !email.isEmpty {
            if allFieldsValid() {
                Authentication.shared.sendRecoveryEmail(to: email) { errorMessage in
                    self.error.text = errorMessage
                    self.error.textColor = .errorRed
                    self.enable()
                } onComplete: {
                    self.error.text = "If an account with your details exists an email address has been sent!"
                    self.error.textColor = .charcoal
                    self.enable()
                }
            }
            else {
                self.enable()
            }
        }
        else {
            self.error.text = "Fill in your email address to continue."
            self.enable()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

