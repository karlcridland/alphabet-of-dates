//
//  Navigation.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class Navigation {
    
    let view: NavigationView = NavigationView()
    let master: MasterView = MasterView()
    let screens: NavigationScreens = NavigationScreens()
    let menu: Menu = Menu()
    
    init() {
        DatabaseManager.shared.getID { id in
            ActivityManager.getActivities(id) {
                self.screens.all.forEach { view in
                    self.master.addSubview(view)
                    view.display()
                }
                self.master.addSubview(self.menu.view)
            }
        }
        self.displayActivities()
        self.view.menuButton.addTarget(self.menu, action: #selector(self.menu.toggle), for: .touchUpInside)
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
    
    init() {
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display() {
    }
    
}

class EditActivityScreenView: ScreenView {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
