//
//  ActivityViewModel.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 24/10/2025.
//

import Combine
import SwiftUI

class ActivityViewModel: ObservableObject {
    
    let character: Character
    var activity: Activity?
    
    init(character: Character, activity: Activity?) {
        self.character = character
        self.activity = activity
    }
    
}
