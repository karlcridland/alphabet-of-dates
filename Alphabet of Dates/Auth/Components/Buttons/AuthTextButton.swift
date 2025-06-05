//
//  AuthSubmitButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthTextButton: UIButton {
    
    init(_ text: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        self.setTitleColor(.maroon.withAlphaComponent(0.7), for: .normal)
        self.setTitleColor(.frostedWhite, for: .highlighted)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
