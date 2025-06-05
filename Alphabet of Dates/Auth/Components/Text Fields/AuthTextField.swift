//
//  AuthTextField.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 04/06/2025.
//

import UIKit

class AuthTextField: UIButton, UITextFieldDelegate {
    
    private let textField: UITextField = UITextField()
    private let placeholder: UILabel = UILabel()
    private let icon: UIImageView = UIImageView()
    
    private var active_height, inactive_height: NSLayoutConstraint?
    
    var errorMessage: String?
    
    var nextField: AuthTextField?
    
    init(_ placeholder: String, _ textContentType: UITextContentType = .emailAddress) {
        super.init(frame: .zero)
        
        let isPassword = textContentType == .password || textContentType == .newPassword
        
        self.backgroundColor = .frostedWhite
        self.clipsToBounds = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 16
        self.layer.cornerCurve = .continuous
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.permaCharcoal.cgColor
        
        self.placeholder.text = placeholder
        self.placeholder.isUserInteractionEnabled = false
        
        self.textField.textContentType = textContentType
        self.textField.tintColor = .lilac
        self.textField.delegate = self
        self.textField.returnKeyType = .done
        self.textField.font = .systemFont(ofSize: 16, weight: .semibold)
        self.textField.isSecureTextEntry = isPassword
        self.textField.addTarget(self, action: #selector(self.returnKeyPressed), for: .primaryActionTriggered)
        
        self.addTarget(self, action: #selector(self.becomeFirstResponder), for: .touchUpInside)
        
        self.fields.forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.active_height = self.placeholder.heightAnchor.constraint(equalToConstant: 36)
        self.inactive_height = self.placeholder.heightAnchor.constraint(equalTo: self.heightAnchor)
        self.updatePlaceholder()
        
    }
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        self.textField.addTarget(target, action: action, for: controlEvents)
    }
    
    var isValid: Bool {
        return !(self.textField.text?.isEmpty ?? true)
    }
    
    func set(next: AuthTextField) {
        self.nextField = next
        self.textField.returnKeyType = .next
    }
    
    func set(value: String?) {
        self.textField.text = value
        self.updatePlaceholder()
    }
    
    @objc func returnKeyPressed() {
        if let field = self.nextField {
            let _ = field.becomeFirstResponder()
        }
        else {
            let _ = self.resignFirstResponder()
            self.resetScrollView()
        }
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            self.textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textField.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.placeholder.topAnchor.constraint(equalTo: self.topAnchor),
            self.placeholder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.placeholder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.focusInScrollView()
        UIView.animate(withDuration: 0.5) {
//            self.shadow(distance: 7)
//            self.transform = CGAffineTransform(translationX: -1, y: -5)
            self.updatePlaceholder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
//            self.shadow(distance: 0)
//            self.transform = CGAffineTransform.identity
            self.updatePlaceholder()
        }
    }
    
    func updatePlaceholder() {
        let isActive: Bool = self.textField.isFirstResponder || !(self.value?.isEmpty ?? true)
        self.inactive_height?.isActive = !isActive
        self.active_height?.isActive = isActive
        self.placeholder.font = .systemFont(ofSize: isActive ? 12 : 18, weight: .semibold)
        self.placeholder.alpha = isActive ? 0.7 : 1
        self.layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.placeholder.layoutIfNeeded()
    }
    
    var value: String? {
        return self.textField.text
    }
    
    var fields: [UIView] {
        return [self.textField, self.placeholder, self.icon]
    }
    
    func scrollTo(_ y: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            if let scroll = self.superview as? UIScrollView {
                scroll.contentOffset.y = y
            }
        }
    }
    
    func focusInScrollView() {
        self.scrollTo(self.frame.minY - 100)
    }
    
    func resetScrollView() {
        self.scrollTo(0)
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
