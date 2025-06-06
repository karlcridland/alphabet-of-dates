//
//  IntroNextButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class IntroNextButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .maroon.withAlphaComponent(0.5)
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 70)
        ])
        self.transform = CGAffineTransform(translationX: 0, y: 200)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
