//
//  NavigationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class NavigationView: UIView {
    
    private let height: CGFloat = 100
    
    init(_ top: CGFloat = 0) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: top + self.height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
