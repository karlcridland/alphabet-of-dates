//
//  AuthenticationTextField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit

class AuthenticationTextField: UITextField {
    
    private var minY: CGFloat = 0
    static let height: CGFloat = 54
    private let back: UIView = UIView()
    
    init(_ type: UITextContentType) {
        super.init(frame: .zero)
        self.frame.size = CGSize(width: AuthenticationView.elementWidth, height: AuthenticationTextField.height)
        self.center.x = UIScreen.main.bounds.midX
        self.isSecureTextEntry = (type == .password || type == .newPassword)
        self.placeholder = type.rawValue
        self.setBack()
        self.textContentType = type
        self.returnKeyType = .done
        self.addTarget(self, action: #selector(self.resignFirstResponder), for: .touchUpInside)
    }
    
    var value: String {
        return self.text ?? ""
    }
    
    private func setBack() {
        self.back.isUserInteractionEnabled = false
        self.back.backgroundColor = .white
        self.back.translatesAutoresizingMaskIntoConstraints = false
        self.back.layer.cornerRadius = AuthenticationView.margin
        self.back.layer.cornerCurve = .continuous
        self.addSubview(self.back)
        NSLayoutConstraint.activate([
            self.back.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -AuthenticationView.margin),
            self.back.rightAnchor.constraint(equalTo: self.rightAnchor, constant: AuthenticationView.margin),
            self.back.topAnchor.constraint(equalTo: self.topAnchor),
            self.back.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func update(to position: Int?) {
        if let position = position {
            let p = CGFloat(position)
            let h = AuthenticationTextField.height
            let m = AuthenticationView.margin
            self.minY = (p * (h + m)) + m
        }
        self.animate(visible: position != nil)
    }
    
    private func animate(visible: Bool) {
        self.isHidden = visible
        self.alpha = visible ? 0 : 1
        UIView.animate(withDuration: 0.3) {
            self.alpha = visible ? 1 : 0
            self.frame.origin.y = self.minY
        } completion: { _ in
            self.isHidden = !visible
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
