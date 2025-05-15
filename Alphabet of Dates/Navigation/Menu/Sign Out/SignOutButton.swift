//
//  SignOutButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 15/05/2025.
//

import UIKit
import FirebaseAuth

class SignOutButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.setTitle("sign out", for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemRed
        self.setTitleColor(.frostedWhite, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.addTarget(self, action: #selector(self.signOutClicked), for: .touchUpInside)
    }
    
    @objc func signOutClicked() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Couldn't sign out.")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
