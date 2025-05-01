//
//  AuthenticationFields.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class AuthenticationFields {
    
    let email = AuthenticationTextField(.emailAddress)
    let password = AuthenticationTextField(.password)
    let confirmPassword = AuthenticationTextField(.password)
    let firstName = AuthenticationTextField(.givenName)
    let lastName = AuthenticationTextField(.familyName)
    
    init() {
        self.displaySignIn()
    }
    
    var all: [AuthenticationTextField] {
        return [self.email, self.password, self.confirmPassword, self.firstName, self.lastName]
    }
    
    @objc func displaySignIn() {
        self.displayFields([self.email, self.password])
    }
    
    @objc func displaySignUp() {
        self.displayFields([self.email, self.firstName, self.lastName, self.password, self.confirmPassword])
    }
    
    @objc func displayForgotPassword() {
        self.displayFields([self.email])
    }
    
    private func displayFields(_ fields: [AuthenticationTextField]) {
        fields.enumerated().forEach { (i, field) in
            field.update(to: i)
        }
        self.all.filter({!fields.contains($0)}).forEach { field in
            field.update(to: nil)
        }
    }
    
}
