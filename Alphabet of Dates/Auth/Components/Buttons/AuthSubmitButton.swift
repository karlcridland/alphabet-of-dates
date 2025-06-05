//
//  AuthSubmitButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthSubmitButton: UIButton {
    
    let loading: UIActivityIndicatorView = UIActivityIndicatorView()
    
    init() {
        super.init(frame: .zero)
        
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .maroon.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        
        self.loading.translatesAutoresizingMaskIntoConstraints = false
        self.loading.isUserInteractionEnabled = false
        self.loading.backgroundColor = self.backgroundColor
        self.loading.color = .frostedWhite
        self.loading.style = .medium
        self.loading.layer.cornerRadius = self.layer.cornerRadius
        self.loading.layer.cornerCurve = self.layer.cornerCurve
        self.addSubview(self.loading)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            self.loading.topAnchor.constraint(equalTo: self.topAnchor),
            self.loading.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.loading.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.loading.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func enable() {
        self.isUserInteractionEnabled = true
        self.setTitleColor(.frostedWhite, for: .normal)
        self.loading.isHidden = true
        self.loading.stopAnimating()
    }
    
    func disable() {
        self.isUserInteractionEnabled = false
        self.setTitleColor(.clear, for: .normal)
        self.loading.isHidden = false
        self.loading.startAnimating()
    }
    
    func set(to type: AuthState) {
        switch type {
        case .signIn:
            self.setTitle("sign in", for: .normal)
            break
        case .signUp:
            self.setTitle("sign up", for: .normal)
            break
        case .recover:
            self.setTitle("send email", for: .normal)
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
