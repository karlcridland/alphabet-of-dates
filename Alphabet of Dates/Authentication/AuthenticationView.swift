//
//  AuthenticationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit

class AuthenticationView: UIView {
    
    var auth: Authentication?
    
    private let fields: AuthenticationFields = AuthenticationFields()
    private let forgotten: AuthenticationChangeStateButton = AuthenticationChangeStateButton(state: .forgotPassword, text: "Forgotten password?")
    private let scroll: UIScrollView = UIScrollView()
    
    let submit: AuthenticationSubmitButton = AuthenticationSubmitButton()
    
    static let margin: CGFloat = 16
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .lilac
        self.fields.all.forEach { field in
            self.scroll.addSubview(field)
        }
        self.addSubview(self.scroll)
        self.addSubview(self.submit)
        self.safeAreaInsetsDidChange()
        self.submit.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
    }
    
    @objc func clicked() {
        switch (Authentication.state) {
        case .signIn:
            self.auth?.signIn(email: fields.email.value, password: fields.password.value) { _ in
            }
            return
        case .signUp:
            return
        case .forgotPassword:
            return
        case .signedIn:
            return
        }
    }
    
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        self.scroll.frame = CGRect(x: 0, y: self.safeAreaInsets.top, width: self.frame.width, height: self.frame.height - self.safeAreaInsets.top - self.safeAreaInsets.bottom - 100)
        self.submit.frame = CGRect(x: 0, y: self.scroll.frame.maxY + 18, width: AuthenticationView.elementWidth, height: 60)
        self.submit.center.x = UIScreen.main.bounds.midX
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var elementWidth: CGFloat {
        let minWidth: CGFloat = UIScreen.main.bounds.width - (AuthenticationView.margin * 4)
        return [minWidth, 420].min()!
    }
    
}
