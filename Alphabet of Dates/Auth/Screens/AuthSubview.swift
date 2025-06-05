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
    let error: AuthErrorMessageView = AuthErrorMessageView()
    
    var hasSetLayout: Bool = false
    
    init(type: AuthState) {
        self.type = type
        super.init(frame: UIScreen.main.bounds)
        self.submit.set(to: type)
        [self.scroll, self.submit, self.privacy].forEach { view in
            self.addSubview(view)
        }
        self.scroll.addSubview(self.icon)
        self.scroll.clipsToBounds = false
        self.scroll.delegate = self
        self.scroll.translatesAutoresizingMaskIntoConstraints = false
        self.scroll.isScrollEnabled = false
        
        self.submit.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
    }
    
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        if !self.hasSetLayout {
            self.setLayout()
            self.hasSetLayout = true
        }
    }
    
    var fields: [AuthTextField] {
        return []
    }
    
    func allFieldsValid() -> Bool {
        var valid = true
        var errorMessage: String?
        self.fields.forEach { field in
            if (!field.isValid) {
                if (errorMessage == nil) {
                    errorMessage = field.errorMessage
                }
                valid = false
            }
        }
        self.error.text = errorMessage
        return valid
    }
    
    func enable() {
        self.submit.enable()
        self.scroll.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.scroll.alpha = 1
        }
    }
    
    func disable() {
        self.submit.disable()
        self.scroll.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.scroll.alpha = 0.4
        }
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            self.scroll.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 12),
            self.icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.icon.topAnchor.constraint(equalTo: self.scroll.topAnchor, constant: 10),
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
        if let next = view as? AuthTextField {
            next.addTarget(self, action: #selector(self.clearError), for: .editingChanged)
            if let previous = previous as? AuthTextField {
                previous.set(next: next)
            }
        }
        self.scroll.addSubview(view)
        self.horizontallyPlace(view: view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: previous?.bottomAnchor ?? self.icon.bottomAnchor, constant: 15),
        ])
        return view
    }
    
    @objc func clearError() {
        self.error.text = nil
    }
    
    @objc func clicked() {
        self.disable()
    }
    
    override func resignFirstResponder() -> Bool {
        self.fields.forEach { field in
            let _ = field.resignFirstResponder()
        }
        return super.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
