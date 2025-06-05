//
//  AuthSignUpLabel.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthSignUpLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 14, weight: .bold)
        self.textColor = .charcoal
        self.numberOfLines = 2
        self.textAlignment = .center
        self.text = "Don't have an account with us?\n(or you've been given a reference code)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
