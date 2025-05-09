//
//  NavigationScreens.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// Easy way to access the screens from the navigation class.

class NavigationScreens {
    
    let activities: ActivityScreenView = ActivityScreenView()
    let edit_activities: EditActivityScreenView = EditActivityScreenView()
    
    var all: [ScreenView] {
        return [self.activities, self.edit_activities]
    }
    
}
