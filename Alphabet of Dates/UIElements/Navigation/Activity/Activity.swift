//
//  Activity.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//




class Activity {
    
    let view: ActivityView
    
    init(_ data: DateData) {
        let position: Int = String.alphabet.firstIndex(of: data.character) ?? 0
        self.view = ActivityView(position)
    }
    
}