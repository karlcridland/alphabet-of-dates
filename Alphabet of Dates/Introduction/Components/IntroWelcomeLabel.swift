//
//  IntroWelcomeLabel.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroWelcomeLabel: IntroInfoView {
    
    let scrollLabel: UILabel = UILabel()
    
    init() {
        super.init(title: "Welcome to the Alphabet of Dates!", subtitle: "26 surprise dates. One for each letter.\nOne of you plans. One of you discovers. Both of you enjoy.")
        
        self.scrollLabel.text = "(scroll down to continue)"
        self.scrollLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        self.addSubview(self.scrollLabel)
        
        NSLayoutConstraint.activate([
            self.scrollLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.scrollLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
