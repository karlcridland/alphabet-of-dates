//
//  ActivityScreenView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// This is the main screen view, it shows all activities/dates to a user.

class ActivityScreenView: ScreenView {
    
    override init() {
        super.init()
        self.contentSize.width = UIScreen.main.bounds.width
        self.clipsToBounds = false
    }
    
    override func display() {
        let y = self.contentOffset.y
        String.alphabet.forEach { char in
            if let activity = ActivityManager.all.first(where: {$0.key == char})?.value {
                self.addSubview(activity.view)
                self.contentSize.height = activity.view.frame.maxY + activity.view.margin
            }
        }
        self.contentOffset.y = y
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
