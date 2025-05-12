//
//  ActivityView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// Creates an instance of an activity view which a user can scroll through the pictures
// of or perform some quick actions like going full screen, adding a photo, or setting a
// favourite item.


class ActivityView: UIView {
    
    let margin: CGFloat = 12
    let label: UILabel = UILabel()
    let scroll: ActivityScrollView
    let optionButton: ActivityOptionsButton
    
    var buttons: [ActivityButton] = []
    
    init(_ position: Int) {
        let width: CGFloat = (UIScreen.main.bounds.width - (3 * self.margin)) / 2
        let height: CGFloat = width * 1.2
        let x: CGFloat = CGFloat(position % 2) * (width + self.margin) + self.margin
        let y: CGFloat = CGFloat(position / 2) * (height + self.margin) + self.margin
        let size = CGSize(width: width, height: height)
        self.scroll = ActivityScrollView(size: size)
        self.optionButton = ActivityOptionsButton(size: size)
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        
        [self.label, self.scroll, self.optionButton].forEach { view in
            self.addSubview(view)
            view.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        }
        self.label.frame.size.height = width * 1.15
        self.style()
    }
    
    func style() {
        self.label.textColor = .charcoal
        self.backgroundColor = .frostedWhite
        [self, self.scroll, self.optionButton].forEach { view in
            view.layer.cornerRadius = 24
            view.layer.cornerCurve = .continuous
        }
    }
    
    func set(_ activity: Activity) {
        self.scroll.set(activity)
        self.optionButton.set(activity)
        self.label.text = activity.character
        self.label.textAlignment = .center
        self.label.font = UIFont(name: "PlayfairDisplay-Black", size: 90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
