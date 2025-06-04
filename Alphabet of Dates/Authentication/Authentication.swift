//
//  Authentication.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import FirebaseAuth
import FirebaseMessaging

class Authentication {
    
    static var state: AuthenticationState = .signIn
    let view = AuthView()
    
    public static let shared: Authentication = Authentication()
    
    private init() {
        self.view.auth = self
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = Auth.auth().currentUser {
                print(user.email ?? "")
                self.view.isHidden = true
                Authentication.state = .signedIn
            }
            else {
                print("no user")
                self.view.isHidden = false
                Authentication.state = .signIn
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print(error)
            }
            self.updateToken()
        }
    }
    
    func updateToken() {
        Messaging.messaging().token { token, _ in
            if let token = token {
                DatabaseManager.shared.set(token: token)
            }
        }
    }
    
}
