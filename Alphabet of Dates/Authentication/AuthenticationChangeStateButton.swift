//
//  AuthenticationChangeStateButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class AuthenticationChangeStateButton: UIButton {
    
    private let authState: AuthenticationState
    
    init(state: AuthenticationState, text: String) {
        self.authState = state
        super.init(frame: CGRect(x: 0, y: 0, width: AuthenticationView.elementWidth, height: 60))
        self.center.x = UIScreen.main.bounds.midX
        self.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
        self.setTitle(text, for: .normal)
    }
    
    @objc func clicked() {
        Authentication.state = self.authState
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
