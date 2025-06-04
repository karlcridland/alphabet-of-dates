//
//  AuthIconView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthIconView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: "logo")
        self.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 140),
            self.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
