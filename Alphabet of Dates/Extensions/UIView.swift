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
    
}
