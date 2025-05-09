//
//  ActivitySetter.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 28/02/2025.
//

import UIKit

class ActivitySetter {
    
    let view = ActivitySetterView()
    let settingsButton: SettingsButton = SettingsButton()
    
    static var buttons: [String: ActivitySetterHeaderButton] = [:]
    
    var current: String = "A"
    
    init() {
        view.ActivitySetter = self
        settingsButton.activitySetter = self
        
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ12".forEach { character in
            let button = ActivitySetterHeaderButton(String(character))
            button.activitySetter = self
            self.view.scroll.addSubview(button)
            self.view.scroll.contentSize.width = button.frame.maxX + button.margin
            ActivitySetter.buttons[String(character)] = button
        }
        if let a = ActivitySetter.buttons["A"] {
            a.click(sender: a)
        }
        self.view.save.addTarget(self, action: #selector(self.save), for: .touchUpInside)
    }
    
    @objc func save() {
        if let id = ViewController.manager.id {
            DatabaseManager.shared.setActivity(char: self.current, id: id, name: self.name, date: self.date)
        }
    }
    
    var name: String? {
        let text = view.activity.value
        return text == "" ? nil : text
    }
    
    var date: String? {
        let year: String = view.year.value
        let month: String = view.month.value
        let day: String = view.day.value
        let text = "\(year)-\(month)-\(day)"
        return text == "--" ? nil : text
    }
    
}
