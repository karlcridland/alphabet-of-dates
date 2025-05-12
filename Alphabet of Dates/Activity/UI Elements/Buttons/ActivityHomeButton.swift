//
//  ActivityImageButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class ActivityHomeButton: ActivityButton {
    
    let photoCount: PhotoCountView = PhotoCountView()
    let label: UILabel = UILabel()
    let date: UILabel = UILabel()
    let dateWrapper: UIView = UIView()
    
    init(size: CGSize) {
        super.init(position: 0, size: size)
        self.addSubview(self.photoCount)
        [self.label, self.dateWrapper, self.date].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            self.photoCount.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            self.photoCount.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            self.dateWrapper.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            self.dateWrapper.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.dateWrapper.heightAnchor.constraint(equalTo: self.photoCount.heightAnchor),
            self.dateWrapper.rightAnchor.constraint(equalTo: self.date.rightAnchor, constant: 5),
            
            self.date.leftAnchor.constraint(equalTo: self.dateWrapper.leftAnchor, constant: 5),
            self.date.topAnchor.constraint(equalTo: self.dateWrapper.topAnchor),
            self.date.bottomAnchor.constraint(equalTo: self.dateWrapper.bottomAnchor),
            
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        
        self.label.textAlignment = .center
        self.label.font = UIFont(name: "LeckerliOne-Regular", size: 18)
        self.label.textColor = .charcoal
        
        self.dateWrapper.backgroundColor = .charcoal
        self.dateWrapper.layer.cornerRadius = 8
        
        self.date.font = self.photoCount.label.font
        self.date.textColor = .frostedWhite
        
    }
    
    override func tapped() {
        if let optionButton = self.activity?.view.optionButton {
            optionButton.selected_image = nil
            optionButton.delete.disable = true
            optionButton.favourite.disable = true
            optionButton.fullScreen.disable = true
            optionButton.addImage.disable = !(self.activity?.canReveal ?? false)
            super.tapped()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
