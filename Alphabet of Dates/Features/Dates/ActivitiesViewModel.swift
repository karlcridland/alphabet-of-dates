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
    
    func view(for character: Character) -> ActivityView {
        let activity = activityManager?.get(character: character)
        let view = ActivityView(character: character, activity: activity)
        return view
    }
    
}
