//
//  ActivityImageButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class ActivityHomeButton: ActivityButton {
    
    init(size: CGSize) {
        super.init(position: 0, size: size)
    }
    
    override func tapped() {
        if let optionButton = self.activity?.view.optionButton {
            optionButton.selected_image = nil
            optionButton.delete.disable = true
            optionButton.favourite.disable = true
            optionButton.fullScreen.disable = true
            optionButton.addImage.disable = false
            super.tapped()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
