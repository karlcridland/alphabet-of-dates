//
//  AuthSubmitButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthPrivacyButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.setTitleColor(.frostedWhite, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("privacy policy", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        self.setTitleColor(.frostedWhite, for: .normal)
        self.setTitleColor(.neon, for: .focused)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AuthRecoverButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.setTitleColor(.frostedWhite, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("forgotten password?", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        self.setTitleColor(.frostedWhite, for: .normal)
        self.setTitleColor(.neon, for: .focused)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
