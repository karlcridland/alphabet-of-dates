//
//  AuthErrorMessageView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class AuthErrorMessageView: UILabel {
    
    var height: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .errorRed
        self.font = .systemFont(ofSize: 14, weight: .semibold)
        self.textAlignment = .center
        self.numberOfLines = 2
        self.height = self.heightAnchor.constraint(equalToConstant: 36)
        self.height?.isActive = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
