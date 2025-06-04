//
//  AuthSubview.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthSubview: UIView, UIScrollViewDelegate {
    
    let type: AuthState
    
    let scroll: UIScrollView = UIScrollView()
    
    let icon: AuthIconView = AuthIconView()
    let submit: AuthSubmitButton = AuthSubmitButton()
    let privacy: AuthPrivacyButton = AuthPrivacyButton()
    
    var hasSetLayout: Bool = false
    
    init(type: AuthState) {
        self.type = type
        super.init(frame: UIScreen.main.bounds)
        self.submit.set(to: type)
        [self.icon, self.scroll, self.submit, self.privacy].forEach { view in
            self.addSubview(view)
        }
        self.scroll.clipsToBounds = false
        self.scroll.delegate = self
        self.scroll.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        if !self.hasSetLayout {
            self.setLayout()
            self.hasSetLayout = true
        }
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.icon.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 12),
            self.icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.scroll.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 10),
            self.scroll.bottomAnchor.constraint(equalTo: self.submit.topAnchor, constant: -10),
            
            self.submit.bottomAnchor.constraint(equalTo: self.privacy.topAnchor, constant: -16),
            
            self.privacy.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.safeAreaInsets.bottom + 4)),
        ])
        self.horizontallyPlace(view: self.privacy)
        self.horizontallyPlace(view: self.submit)
        self.horizontallyPlace(view: self.scroll)
    }
    
    func horizontallyPlace(view: UIView, margin: CGFloat = 15) {
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin),
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin),
        ])
    }
    
    public func placeToScroll(_ views: [UIView]) {
        var previous: UIView?
        views.forEach { view in
            previous = self.placeToScroll(view: view, previous: previous)
        }
    }
    
    private func placeToScroll(view: UIView, previous: UIView?) -> UIView {
        if let a = previous as? AuthTextField, let b = view as? AuthTextField {
            a.set(next: b)
        }
        self.scroll.addSubview(view)
        self.horizontallyPlace(view: view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: previous?.bottomAnchor ?? self.scroll.topAnchor, constant: 20),
        ])
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
