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
    
    var auth: Authentication?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .lilac
        self.all.forEach { view in
            self.addSubview(view)
        }
        self.update()
    }
    
    var all: [AuthSubview] {
        return [self.signIn, self.signUp, self.recover]
    }
    
    func hideAll() {
        self.all.forEach { view in
            view.isHidden = true
        }
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
