//
//  AuthenticationView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit

class AuthenticationView: UIView, UITextFieldDelegate {
    
    let textField: UITextField = UITextField()
    
    let fields: UIView = UIView()
    let margin: CGFloat = 10
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .lilac
        
        self.fields.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.fields)
        self.addSubview(self.textField)
        self.textField.isHidden = true
        self.textField.delegate = self
        
        var previous: UIView?
        
        for i in 0 ..< 5 {
            let field = AuthCharButton(i)
            self.fields.addSubview(field)
            NSLayoutConstraint.activate([
                field.leftAnchor.constraint(equalTo: previous?.rightAnchor ?? fields.leftAnchor, constant: self.margin),
                field.topAnchor.constraint(equalTo: fields.topAnchor),
                fields.bottomAnchor.constraint(equalTo: field.bottomAnchor)
            ])
            previous = field
            field.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        }
        
        if let previous = previous {
            NSLayoutConstraint.activate([
                self.fields.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.fields.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -UIScreen.main.bounds.height / 4),
                self.fields.rightAnchor.constraint(equalTo: previous.rightAnchor, constant: self.margin)
            ])
        }
        
    }
    
    @objc func buttonClicked(_ sender: AuthCharButton) {
        if (!self.textField.isFirstResponder) {
            self.textField.becomeFirstResponder()
        }
        self.update()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.text = textField.text?.prefix(5).lowercased()
        let f = all_fields
        self.resetFields()
        textField.text?.map({$0.lowercased()}).enumerated().forEach({ (i, char) in
            if let first = f.first(where: {$0.position == i}) {
                first.setTitle(char, for: .normal)
            }
        })
        if let user = Users(rawValue: textField.text ?? "")?.user {
            Authentication.shared.signIn(with: user)
        }
        self.update()
    }
    
    func update() {
        let position = self.textField.cursorPosition()
        all_fields.forEach { button in
            button.setActive(self.textField.isFirstResponder && button.position == position)
        }
    }
    
    var all_fields: [AuthCharButton] {
        var results: [AuthCharButton] = []
        self.fields.subviews.forEach { view in
            if let button = view as? AuthCharButton {
                results.append(button)
            }
        }
        return results.sorted(by: {$0.position < $1.position})
    }
    
    func resetFields() {
        self.all_fields.forEach { $0.setTitle(nil, for: .normal) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AuthCharButton: UIButton {
    
    let position: Int
    
    init(_ position: Int) {
        self.position = position
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        self.layer.cornerCurve = .continuous
        self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        self.setActive(false)
        self.setTitleColor(.black, for: .normal)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 50),
            self.heightAnchor.constraint(equalToConstant: 64),
        ])
        
    }
    
    func setActive(_ isActive: Bool) {
        self.backgroundColor = isActive ? .charcoal : .frostedWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    
    func cursorPosition() -> Int {
        guard let selectedRange = self.selectedTextRange else { return 0 }
        return self.offset(from: self.beginningOfDocument, to: selectedRange.start)
    }
    
}
