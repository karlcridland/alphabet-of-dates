//
//  UIView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

extension UIView {
    
    func removeAllSubiews() {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func shadow(angle: CGFloat = 80, distance: CGFloat = 10, color: UIColor = .maroon) {
        let angleRadians = angle * (.pi / 180)
        let dx = cos(angleRadians) * distance
        let dy = sin(angleRadians) * distance
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.20
        self.layer.shadowOffset = CGSize(width: dx, height: dy)
        self.layer.shadowRadius = 0
        self.layer.masksToBounds = false
    }
    
}
