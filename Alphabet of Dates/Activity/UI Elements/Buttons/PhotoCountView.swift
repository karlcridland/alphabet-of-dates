//
//  PhotoCountView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 10/05/2025.
//

import UIKit


class PhotoCountView: UIView {
    
    let icon: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    
    let size: CGFloat = 24
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.update(quantity: 0)
        [self.icon, self.label].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            self.icon.heightAnchor.constraint(equalToConstant: self.size),
            self.icon.heightAnchor.constraint(equalToConstant: self.size),
            self.icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            self.label.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 5),
            self.label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])
        
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
        self.icon.image = UIImage(systemName: "photo", withConfiguration: config)
        self.icon.contentMode = .scaleAspectFit
        self.icon.tintColor = .frostedWhite
        self.label.textColor = .frostedWhite
        self.backgroundColor = .charcoal
        self.label.font = .systemFont(ofSize: 12, weight: .bold)
        self.layer.cornerRadius = 8
    }
    
    func update(quantity: Int) {
        self.isHidden = quantity == 0
        self.label.text = "\(quantity)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
