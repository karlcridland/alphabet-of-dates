//
//  Authentication.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import FirebaseAuth
import FirebaseMessaging

class Authentication {
    
    let view = AuthenticationView()
    
    public static let shared: Authentication = Authentication()
    
    private init() {
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.view.removeFromSuperview()
                ViewController.manager.update()
            }
        }
//        do {
//            try Auth.auth().signOut()
//        }
//        catch {
//            
//        }
    }
    
    func signIn(with user: User) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { _, error in
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
