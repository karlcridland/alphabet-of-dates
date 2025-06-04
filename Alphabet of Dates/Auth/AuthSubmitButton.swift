//
//  AuthSubmitButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthSubmitButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .maroon.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func set(to type: AuthState) {
        switch type {
        case .signIn:
            self.setTitle("sign in", for: .normal)
            break
        case .signUp:
            self.setTitle("sign up", for: .normal)
            break
        case .recover:
            self.setTitle("recover", for: .normal)
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
