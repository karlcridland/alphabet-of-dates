//
//  Menu.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class Menu {
    
    var isDisplayed: Bool = false
    
    let view: MenuView = MenuView()
    var nav: Navigation?
    
    init() {
        self.view.exitButton.addTarget(self, action: #selector(self.exitMenu), for: .touchUpInside)
    }
    
    @objc func exitMenu() {
        self.isDisplayed = true
        self.toggle()
    }
    
    @objc func toggle() {
        self.isDisplayed = !self.isDisplayed
        self.isDisplayed ? self.view.slideIn() : self.view.slideOut()
    }
    
}
