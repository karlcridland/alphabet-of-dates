//
//  Navigation.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class Navigation {
    
    let view: NavigationView = NavigationView()
    let manager: ActivityManager = ActivityManager()
    let master: MasterView = MasterView()
    let screens: NavigationScreens = NavigationScreens()
    
    init() {
        DatabaseManager.shared.getID { id in
            self.manager.getActivities(id) {
                self.screens.all.forEach { view in
                    self.master.addSubview(view)
                    view.display(self.manager)
                }
            }
        }
        self.displayActivities()
    }
    
    @objc func displayActivities() {
        self.displayScreen(self.screens.activities)
    }
    
    @objc func displayEditActivities() {
        self.displayScreen(self.screens.edit_activities)
    }
    
    private func displayScreen(_ screen: ScreenView) {
        self.screens.all.forEach { view in
            view.isHidden = screen != view
        }
    }
    
}

class ScreenView: UIScrollView {
    
    var id: String?
    
    func display(_ manager: ActivityManager) {
    }
    
}

class EditActivityScreenView: ScreenView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
