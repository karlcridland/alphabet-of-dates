//
//  NavigationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class NavigationView: UIView {
    
    let height: CGFloat = 60
    
    let menuButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    let blur: UIVisualEffectView = UIVisualEffectView()
    
    init(_ top: CGFloat = 0) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: top + self.height))
        self.backgroundColor = .frostedWhite
        self.isHidden = true
        
        [self.blur, self.menuButton, self.titleLabel].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.menuButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.menuButton.widthAnchor.constraint(equalToConstant: self.height),
            self.menuButton.heightAnchor.constraint(equalToConstant: self.height),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.menuButton.topAnchor),
            self.titleLabel.leftAnchor.constraint(equalTo: self.menuButton.rightAnchor),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            
            self.blur.topAnchor.constraint(equalTo: self.topAnchor),
            self.blur.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.blur.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .black)
        self.menuButton.setImage(UIImage(systemName: "line.3.horizontal", withConfiguration: config), for: .normal)
        self.menuButton.tintColor = .charcoal
        
        self.titleLabel.text = "Your dates"
        self.titleLabel.textAlignment = .right
        self.titleLabel.textColor = .charcoal
        self.titleLabel.font = UIFont(name: "LeckerliOne-Regular", size: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
