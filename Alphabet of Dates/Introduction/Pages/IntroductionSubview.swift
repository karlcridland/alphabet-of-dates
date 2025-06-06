//
//  IntroductionSubview.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class IntroductionSubview: UIView {
    
    var nextPage, previousPage: IntroductionSubview?
    let nextButton = IntroNextButton()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
        self.addSubview(self.nextButton)
        NSLayoutConstraint.activate([
            self.nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
