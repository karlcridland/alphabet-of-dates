//
//  ActivitiesView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 21/10/2025.
//

import Combine

class ActivitiesViewModel: ObservableObject {
    
    private var activityManager: ActivityManager?
    
    init(id: String?) {
        if let id = id {
            self.activityManager = ActivityManager(id)
        }
    }
    
    func get(for char: Character) -> Activity? {
        return activityManager?.get(character: char)
    }
    
}
