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
        view.wrapTo(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    func wrapTo(view: UIView, maxWidth: CGFloat? = nil, addToSubview: Bool = false) {
        if (addToSubview) {
            view.addSubview(self)
        }
        self.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = [
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        
        let widthConstraint = self.widthAnchor.constraint(equalTo: view.widthAnchor)

        if let maxWidth = maxWidth {
            let maxWidthConstraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
            maxWidthConstraint.priority = .required
            widthConstraint.priority = .defaultHigh
            constraints.append(contentsOf: [maxWidthConstraint])
        } else {
            widthConstraint.priority = .required
        }
        constraints.append(widthConstraint)

        NSLayoutConstraint.activate(constraints)
    }
    
}
