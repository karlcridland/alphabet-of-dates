//
//  IntroHowItWorksLabel.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroHowItWorksLabel: IntroInfoView {
    
    init() {
        super.init(title: "How it works", subtitle: "One of you takes the lead and plans a surprise date for each letter, the other won’t know what’s coming until the date is revealed! Anything can be picked for a date as long as it corresponds to a letter, for example...")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
