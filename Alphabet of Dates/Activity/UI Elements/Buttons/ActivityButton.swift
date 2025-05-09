//
//  ActivityButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// Creates a template button used to be placed on the activity views, on click
// should prompt a list of options.

class ActivityButton: UIButton {
    
    let position: Int
    var activity: Activity?

    init(position: Int, size: CGSize) {
        self.position = position
        super.init(frame: CGRect(origin: CGPoint(x: size.width * CGFloat(position), y: 0), size: size))
        self.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        self.activity?.view.optionButton.appear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
