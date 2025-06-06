//
//  IntroductionView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class IntroductionView: UIView {
    
    let welcome: IntroWelcomeView = IntroWelcomeView()
    let picture: IntroPictureView = IntroPictureView()
    let invite: IntroInviteView = IntroInviteView()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.pages.forEach { page in
            page.wrapTo(view: self, addToSubview: true)
        }
        self.welcome.isHidden = false
        self.isHidden = true
    }
    
    func hideAll() {
        self.pages.forEach { view in
            view.isHidden = true
        }
    }
    
    var pages: [IntroductionSubview] {
        return [self.welcome, self.picture, self.invite]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
