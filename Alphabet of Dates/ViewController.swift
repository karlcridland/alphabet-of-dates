//
//  ViewController.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit
import FirebaseAuth

class ViewController: ImageViewController {
    
    let navigation: Navigation = Navigation()
    let auth: Authentication = Authentication.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        [self.navigation.master, self.navigation.view, self.auth.view, self.navigation.intro.view, FullScreenManager.shared.view].forEach { view in
            self.view.addSubview(view)
        }
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.navigation.view.frame.size.height = self.view.safeAreaInsets.top + self.navigation.view.height
        NSLayoutConstraint.activate([
            self.navigation.master.topAnchor.constraint(equalTo: self.navigation.view.bottomAnchor),
            self.navigation.master.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.navigation.master.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.navigation.master.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.safeAreaInsets.bottom),
            
            self.navigation.intro.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.navigation.intro.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.navigation.intro.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.navigation.intro.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}
