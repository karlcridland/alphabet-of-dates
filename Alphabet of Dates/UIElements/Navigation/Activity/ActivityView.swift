//
//  ActivityView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// Creates an instance of an activity view which a user can scroll through the pictures
// of or perform some quick actions like going full screen, adding a photo, or setting a
// favourite item.


class ActivityView: UIButton {
    
    let margin: CGFloat = 12
    
    init(_ position: Int) {
        let width: CGFloat = (UIScreen.main.bounds.width - (3 * self.margin)) / 2
        let height: CGFloat = width * 1.2
        let x: CGFloat = CGFloat(position % 2) * (width + self.margin) + self.margin
        let y: CGFloat = CGFloat(position / 2) * (height + self.margin) + self.margin
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        
        self.backgroundColor = .sageGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
