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
    
    var onSignIn: (() -> Void)?
    
    public static let shared: Authentication = Authentication()
    
    private init() {
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = Auth.auth().currentUser {
                self.view.isHidden = true
                Authentication.state = .signedIn
                self.onSignIn?()
            }
            else {
                self.view.isHidden = false
                Authentication.state = .signIn
            }
        }
    }
    
    func signIn(email: String, password: String, _ errorMessage: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error?.localizedDescription {
                if (error == "The supplied auth credential is malformed or has expired.") {
                    errorMessage("Incorrect email or password.")
                }
                else {
                    errorMessage(error)
                }
            }
            self.updateToken()
        }
    }
    
    func signUp(email: String, password: String, name: Name, _ errorMessage: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            print(result, error)
            if let error = error?.localizedDescription {
                errorMessage(error)
            }
            if let uid = result?.user.uid {
                DatabaseManager.shared.set(name: name, uid: uid)
            }
            self.updateToken()
        }
    }
    
    func sendRecoveryEmail(to email: String, _ errorMessage: @escaping (String) -> Void, onComplete: @escaping () -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error?.localizedDescription {
                errorMessage(error)
            }
            else {
                onComplete()
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error signing out.")
        }
    }
    
    func updateToken() {
        Messaging.messaging().token { token, _ in
            if let token = token {
                DatabaseManager.shared.set(token: token)
            }
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
}

struct Name {
    let first, last: String
}
