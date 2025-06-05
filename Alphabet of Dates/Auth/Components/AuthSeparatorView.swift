//
//  AuthSeparatorView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthSeparatorView: UIView {
    
    private let bar: UIView = UIView()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.bar)
        
        self.bar.backgroundColor = .charcoal.withAlphaComponent(0.6)
        self.bar.layer.cornerRadius = 1.5
        
        NSLayoutConstraint.activate([
            self.bar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.bar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.bar.heightAnchor.constraint(equalToConstant: 3),
            self.bar.widthAnchor.constraint(equalToConstant: max(300, UIScreen.main.bounds.width * 0.7)),
            self.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
