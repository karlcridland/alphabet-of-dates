//
//  IntroView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .frostedWhite
        self.layer.cornerRadius = 20
        self.layer.cornerCurve = .continuous
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.permaCharcoal.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
