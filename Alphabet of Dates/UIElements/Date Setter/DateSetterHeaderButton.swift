//
//  DateSetterHeaderButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 28/02/2025.
//

import UIKit

class DateSetterHeaderButton: UIButton {
    
    var data: DateData?
    var dateSetter: DateSetter?
    let char: String
    
    let width: CGFloat = 60
    let margin: CGFloat = 10
    
    let label: UILabel = UILabel()
    let nameCheck, dateCheck: UIImageView
    
    init(_ char: String) {
        self.char = char
        self.nameCheck = UIImageView(frame: CGRect(x: 0, y: 50, width: width, height: 30))
        self.dateCheck = UIImageView(frame: CGRect(x: 0, y: 80, width: width, height: 30))
        super.init(frame: CGRect(x: margin + (char.position * (width + margin)), y: 0, width: width, height: 120))
        self.label.frame = CGRect(x:0, y: 10, width: width, height: 30)
        
        self.label.text = char
        self.label.textAlignment = .center
        self.label.font = UIFont(name: "PlayfairDisplay-Black", size: 30)
        self.label.textColor = .charcoal
        
        self.backgroundColor = .frostedWhite
        self.layer.cornerRadius = 20
        self.layer.cornerCurve = .continuous
        
        [self.label, self.nameCheck, self.dateCheck].forEach { view in
            self.addSubview(view)
            
            if let imageView = view as? UIImageView {
                imageView.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = .charcoal
            }
        }
        
        if let button = ViewController.manager.buttons.first(where: {$0.character == self.char}) {
            button.dateSetterButton = self
        }
        self.addTarget(self, action: #selector(self.click), for: .touchUpInside)
    }
    
    @objc func click(sender: DateSetterHeaderButton) {
        self.dateSetter?.view.activity.textField.text = ""
        self.dateSetter?.view.day.textField.text = ""
        self.dateSetter?.view.month.textField.text = ""
        self.dateSetter?.view.year.textField.text = ""
        DateSetter.buttons.values.forEach { button in
            let selected: Bool = button == sender
            let tintColor: UIColor = selected ? .frostedWhite : .charcoal
            button.label.textColor = tintColor
            button.nameCheck.tintColor = tintColor
            button.dateCheck.tintColor = tintColor
            button.backgroundColor = selected ? .charcoal : .frostedWhite
        }
        self.dateSetter?.current = self.char
        self.update(from: self.data)
    }
    
    func updateIcon(for imageView: UIImageView, filled: Bool) {
        imageView.image = UIImage(systemName: filled ? "checkmark.circle.fill" : "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
    }
    
    func update(from data: DateData?) {
        self.data = data
        if let data = data {
            self.updateIcon(for: self.nameCheck, filled: data.hasName)
            self.updateIcon(for: self.dateCheck, filled: data.hasDate)
            self.updateText()
        }
        else {
            self.updateIcon(for: self.nameCheck, filled: false)
            self.updateIcon(for: self.dateCheck, filled: false)
        }
    }
    
    func updateText() {
        if let setter = self.dateSetter,
            setter.current == self.char {
            if (setter.view.activity.textField.text != data?.name) {
                setter.view.activity.textField.text = data?.name
            }
            let dateSplit = data?.revealedOn.split(separator: "-").map({String($0)}) ?? []
            [setter.view.year, setter.view.month, setter.view.day].enumerated().forEach { (i, inputValue) in
                inputValue.textField.text = dateSplit.count == 3 ? dateSplit[i] : ""
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension String {
    var position: CGFloat {
        if ["1", "2"].contains(self) {
            return "z".position + CGFloat(Int(self) ?? 0)
        }
        guard let firstChar = self.lowercased().first, firstChar.isLetter else {
            return -1
        }
        return CGFloat(firstChar.asciiValue! - Character("a").asciiValue!)
    }
}
