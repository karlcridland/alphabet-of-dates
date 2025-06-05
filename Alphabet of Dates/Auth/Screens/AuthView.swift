//
//  AuthView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthView: UIView {
    
    var state: AuthState = .signIn
    
    let signIn: SignInAuthView = SignInAuthView()
    let signUp: SignUpAuthView = SignUpAuthView()
    let recover: RecoverAuthView = RecoverAuthView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .lilac
        self.all.forEach { view in
            self.addSubview(view)
        }
        self.update()
        
        self.signIn.recovery.addTarget(self, action: #selector(self.openRecovery), for: .touchUpInside)
        self.signIn.signUp.addTarget(self, action: #selector(self.openSignUp), for: .touchUpInside)
        self.recover.back.addTarget(self, action: #selector(self.openSignIn), for: .touchUpInside)
        self.signUp.back.addTarget(self, action: #selector(self.openSignIn), for: .touchUpInside)
        
    }
    
    var all: [AuthSubview] {
        return [self.signIn, self.signUp, self.recover]
    }
    
    func hideAll() {
        self.all.forEach { view in
            view.isHidden = true
            view.scroll.contentOffset.y = 0
            let _ = view.resignFirstResponder()
        }
    }
    
    @objc func openSignIn() {
        self.update()
    }
    
    @objc func openSignUp() {
        self.update(to: .signUp)
    }
    
    @objc func openRecovery() {
        self.recover.email.set(value: self.signIn.email.value)
        self.update(to: .recover)
    }
    
    func update(to state: AuthState = .signIn) {
        self.state = state
        self.hideAll()
        if let view = self.all.first(where: {$0.type == state}) {
            view.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
