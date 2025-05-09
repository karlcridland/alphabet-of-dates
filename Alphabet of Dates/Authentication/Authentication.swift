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
    let view = AuthenticationView()
    
    public static let shared: Authentication = Authentication()
    
    private init() {
        self.view.auth = self
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.view.removeFromSuperview()
//                ViewController.manager.update()
                Authentication.state = .signedIn
            }
            else {
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
            self.view.removeFromSuperview()
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
