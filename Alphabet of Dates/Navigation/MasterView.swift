//
//  MasterView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// View that sits on the main view controller and defines the size of the main views
// that a user interacts with. Should also define the views and swap between them.


class MasterView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
