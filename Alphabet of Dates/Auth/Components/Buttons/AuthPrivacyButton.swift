//
//  AuthPrivacyButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthPrivacyButton: AuthTextButton {
    
    init() {
        super.init("privacy policy")
        self.setTitleColor(.maroon.withAlphaComponent(0.5), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
