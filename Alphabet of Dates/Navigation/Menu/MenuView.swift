//
//  MenuView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class MenuView: UIView {
    
    let blur: UIVisualEffectView = UIVisualEffectView()
    let exitButton: UIButton = UIButton()
    let pane: MenuPaneView = MenuPaneView()
    
    init() {
        super.init(frame: .zero)
        [self.blur, self.exitButton, self.pane].forEach { view in
            view.wrapTo(view: self, maxWidth: view == pane ? 300 : nil, addToSubview: true)
        }
        self.isHidden = true
    }
    
    func slideIn() {
        self.animate(true)
    }
    
    @objc func slideOut() {
        self.animate(false)
    }
    
    private func animate(_ display: Bool) {
        self.isHidden = false
        self.pane.transform = display ? CGAffineTransform(translationX: -self.pane.frame.width, y: 0) : CGAffineTransform.identity
        let width: CGFloat = self.pane.frame.width
        UIView.animate(withDuration: 0.4) {
            self.blur.effect = display ? UIBlurEffect(style: .systemUltraThinMaterial) : nil
            self.pane.transform = display ? CGAffineTransform.identity : CGAffineTransform(translationX: -width, y: 0)
            self.blur.frame.origin.x = self.pane.frame.maxX
        } completion: { _ in
            self.isHidden = !display
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
