//
//  MenuPaneView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit


class MenuPaneView: UIView {
    
    let blur: UIVisualEffectView = UIVisualEffectView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .frostedWhite
//        self.blur.wrapTo(view: self, addToSubview: true)
//        self.blur.effect = UIBlurEffect(style: .systemUltraThinMaterial)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
