//
//  ActivityOptionButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

// Provides a user to access more features of an activity with a simple grid
// layout. Should provide a user to be able to go full screen, add an image,
// favourite an image, or delete an image.


class ActivityOptionsButton: UIButton {
    
    var activity: Activity?
    
    let addImage = ActivityOptionsGridButton(systemName: "camera", text: "Add Image")
    let fullScreen = ActivityOptionsGridButton(systemName: "arrow.up.left.and.arrow.down.right", text: "Fullscreen")
    let favourite = ActivityOptionsGridButton(systemName: "star", text: "Favourite")
    let delete = ActivityOptionsGridButton(systemName: "trash", text: "Delete")
    
    let blur: UIVisualEffectView = UIVisualEffectView()
    
    var selected_image: String?
    
    init(size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        let buttonSize = CGSize(width: size.width/2, height: size.height/2)
        self.addSubview(self.blur)
        self.blur.frame.size = size
        self.isHidden = true
        self.isUserInteractionEnabled = false
        self.clipsToBounds = true
        self.buttons.enumerated().forEach { (i, button) in
            let x = CGFloat(i % 2) * buttonSize.width
            let y = CGFloat(i / 2) * buttonSize.height
            button.frame = CGRect(origin: CGPoint(x: x, y: y), size: buttonSize)
            self.addSubview(button)
        }
    }
    
    var buttons: [ActivityOptionsGridButton] {
        return [self.addImage, self.fullScreen, self.favourite, self.delete]
    }
    
    @objc func appear() {
        self.animate(false)
        Timer.scheduledTimer(withTimeInterval: 4.20, repeats: false) { _ in
            self.disappear()
        }
        self.buttons.forEach { button in
            button.isUserInteractionEnabled = !button.disable
        }
    }
    
    @objc func disappear() {
        self.animate(true)
    }
    
    private func animate(_ hide: Bool) {
        self.isHidden = false
        self.isUserInteractionEnabled = !hide
        UIView.animate(withDuration: 0.2) {
            self.blur.effect = hide ?  nil : UIBlurEffect(style: .systemUltraThinMaterialDark)
            self.buttons.forEach { button in
                button.alpha = hide ? 0 : button.disable ? 0.5 : 1
            }
        } completion: { _ in
            self.isHidden = hide
        }
    }
    
    func set(_ activity: Activity) {
        self.activity = activity
        self.addImage.addTarget(activity, action: #selector(activity.uploadPhotoClicked), for: .touchUpInside)
        self.fullScreen.addTarget(activity, action: #selector(activity.fullscreenClicked), for: .touchUpInside)
        self.favourite.addTarget(activity, action: #selector(activity.favouriteImageClicked), for: .touchUpInside)
        self.delete.addTarget(activity, action: #selector(activity.removeImageClicked), for: .touchUpInside)
    }
    
    func enableAll() {
        self.buttons.forEach { button in
            button.disable = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ActivityOptionsGridButton: UIButton {
    
    private let systemName, text: String
    
    let icon: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    
    var disable: Bool = false
    
    init(systemName: String, text: String) {
        self.systemName = systemName
        self.text = text
        super.init(frame: .zero)
        self.alpha = 0
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        self.icon.image = UIImage(systemName: systemName, withConfiguration: config)
        self.icon.tintColor = .frostedWhite
        self.icon.contentMode = .center
        self.label.text = text
        self.label.textAlignment = .center
        self.label.font = .systemFont(ofSize: 12, weight: .bold)
        self.label.textColor = .frostedWhite
        
        [self.icon, self.label].forEach { view in
            self.addSubview(view)
            view.isUserInteractionEnabled = false
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: self.leftAnchor),
                view.rightAnchor.constraint(equalTo: self.rightAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            self.icon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            self.label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            self.icon.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            self.label.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
