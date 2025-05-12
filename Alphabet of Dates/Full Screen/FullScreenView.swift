//
//  FullScreenView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 10/05/2025.
//

import UIKit

class FullScreenView: UIScrollView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .charcoal
        self.isPagingEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
