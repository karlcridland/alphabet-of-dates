//
//  ViewController.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit
import FirebaseAuth

class ViewController: ImageViewController {
    
    let fullScreen: FullScreenView = FullScreenView()
    let dateSetter: ActivitySetter = ActivitySetter()
    let navigation: Navigation = Navigation()
    
    let auth: Authentication = Authentication.shared
    static let manager = DateButtonManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ViewController.manager.scroll)
        self.view.sendSubviewToBack(ViewController.manager.scroll)
        DateButtonManager.viewController = self
        if (self.masterUser) {
            self.view.addSubview(self.dateSetter.view)
            self.view.addSubview(self.dateSetter.settingsButton)
        }
        [self.auth.view, self.navigation.view, self.fullScreen].forEach { view in
            self.view.addSubview(view)
        }
        
        self.dateSetter.settingsButton.isHidden = !self.masterUser
        
//        do {
//            try Auth.auth().signOut()
//        }
//        catch {
//
//        }
    }
    
    var masterUser: Bool {
        return Auth.auth().currentUser?.uid == "PeKvS2bDx3fQacWynvmfLg6clnF3"
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.dateSetter.settingsButton.frame.origin = CGPoint(x: 10, y: self.view.frame.height - self.view.safeAreaInsets.bottom - self.dateSetter.settingsButton.frame.height - 10)
        self.dateSetter.view.setLayout()
        self.navigation.view.frame.size.height = self.view.safeAreaInsets.top + self.navigation.view.height
        
        NSLayoutConstraint.activate([
            ViewController.manager.scroll.topAnchor.constraint(equalTo: self.navigation.view.bottomAnchor),
            ViewController.manager.scroll.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            ViewController.manager.scroll.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            ViewController.manager.scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.safeAreaInsets.bottom),
        ])
        
    }

}
