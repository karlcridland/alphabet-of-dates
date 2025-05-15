//
//  MenuPaneView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit


class MenuPaneView: UIView {
    
    let signOut: SignOutButton = SignOutButton()
    
    let padding: CGFloat = 20
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .frostedWhite
        self.addSubview(self.signOut)
        NSLayoutConstraint.activate([
            self.signOut.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.padding),
            self.signOut.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.padding),
            self.signOut.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.padding),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
