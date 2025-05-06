//
//  DateButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit

class DateButton: UIButton {
    
    static let margin: CGFloat = 16
    
    var activitySetterButton: ActivitySetterHeaderButton?
    
    let letterLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    let meter: DateButtonScrollMeter = DateButtonScrollMeter()
    
    let character: String
    
    init(_ character: String, _ position: Int) {
        self.character = character
        super.init(frame: position.frame)
        
        self.titleLabel?.textColor = .black
        self.backgroundColor = .frostedWhite
        self.clipsToBounds = true
        self.layer.cornerRadius = 24
        self.layer.cornerCurve = .continuous
        
        self.meter.blur.effect = UIBlurEffect(style: .systemThinMaterialLight)
        self.meter.blur.alpha = 0
        
        self.letterLabel.text = ["1", "2"].contains(character) ? "?" : character
        self.descriptionLabel.text = "TBD"
        self.descriptionLabel.numberOfLines = 4
        
        self.meter.update()
        
        if let text = UserDefaults.standard.value(forKey: self.storageKey) as? String, text != "TBD" {
            self.descriptionLabel.text = text
            self.alpha = 1
        }
        else {
            self.alpha = 0.55
        }
        
        [self.letterLabel, self.meter.scroll, self.meter.blur, self.descriptionLabel, self.meter.view].forEach { view in
            if let label = view as? UILabel {
                label.textAlignment = .center
                label.textColor = .charcoal
            }
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = view is DateButtonScrollView
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.letterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.letterLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            self.letterLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.letterLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.letterLabel.bottomAnchor, constant: 20),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            self.meter.blur.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.meter.blur.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.meter.blur.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.meter.blur.topAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            
            self.meter.scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.meter.scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.meter.scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.meter.scroll.topAnchor.constraint(equalTo: self.topAnchor),
            
            self.meter.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.meter.view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        self.letterLabel.font = UIFont(name: "PlayfairDisplay-Black", size: 90)
        self.descriptionLabel.font = UIFont(name: "LeckerliOne-Regular", size: 18)
        self.descriptionLabel.font = .systemFont(ofSize: 17, weight: .bold)
        self.dateLabel.font = .systemFont(ofSize: 14, weight: .black)
        
    }
    
    func update(with id: String) {
        DatabaseManager.shared.getData(for: self.character, with: id) { data in
            self.meter.id = id
            self.meter.char = self.character
            self.isUserInteractionEnabled = data?.canReveal == true
            if let data = data, !data.revealedOn.isEmpty {
                self.descriptionLabel.text = [
                    data.canReveal ? data.name : "Revealed on",
                    data.revealedOn.toDate ?? ""
                ].joined(separator: "\n")
                self.meter.update(with: data)
                UIView.animate(withDuration: 0.5) {
                    self.alpha = 1
                }
            }
            else {
                self.descriptionLabel.text = "TBD"
                UIView.animate(withDuration: 0.5) {
                    self.alpha = 0.55
                }
            }
            self.activitySetterButton?.update(from: data)
            UserDefaults.standard.set(self.descriptionLabel.text, forKey: self.storageKey)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var storageKey: String {
        return "stored-text-for-\(self.character)"
    }
    
}

extension Int {
    
    var frame: CGRect {
        let width: CGFloat = (UIScreen.main.bounds.width - (3 * DateButton.margin)) / 2
        let height: CGFloat = width * 1.2
        let x: CGFloat = CGFloat(self % 2) * (width + DateButton.margin) + DateButton.margin
        let y: CGFloat = CGFloat(self / 2) * (height + DateButton.margin) + DateButton.margin
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
