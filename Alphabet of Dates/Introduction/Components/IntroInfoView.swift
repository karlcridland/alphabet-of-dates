//
//  IntroInfoView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroInfoView: IntroView {
    
    let title: UILabel = UILabel()
    let body: UILabel = UILabel()
    
    init(title: String, subtitle: String, margin: CGFloat = 20, gap: CGFloat = 10) {
        super.init()
        self.shadow(distance: 4)
        
        self.title.text = title
        self.title.font = .systemFont(ofSize: 18, weight: .bold)
        
        self.body.text = subtitle
        self.body.font = .systemFont(ofSize: 16, weight: .medium)
        
        [self.title, self.body].forEach { label in
            self.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .charcoal
            label.numberOfLines = 0
        }
        
        NSLayoutConstraint.activate([
            self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin),
            self.title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: margin),
            
            self.body.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin),
            self.body.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin),
            self.body.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: gap),
            self.bottomAnchor.constraint(equalTo: self.body.bottomAnchor, constant: margin),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
