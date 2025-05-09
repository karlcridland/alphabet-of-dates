//
//  DateButtonScrollMeterView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 26/02/2025.
//

import UIKit

class DateButtonScrollMeterView: UIView {
    
    var finalAnchor: NSLayoutConstraint?
    let cameraIcon = DateButtonScrollMeterIcon(.upload)
    
    init() {
        super.init(frame: .zero)
        let height: CGFloat = DateButtonScrollMeterIcon.size + (2 * DateButtonScrollMeterIcon.margin)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
        self.backgroundColor = .charcoal
        self.layer.cornerRadius = height / 2
        self.alpha = 0
    }
    
    func update(with data: [String: [String: String]] = [:]) {
        self.removeAll()
        var previous: DateButtonScrollMeterIcon = self.place(icon: self.cameraIcon, nextTo: nil)
        data.forEach { (id, images) in
            images.keys.forEach { image in
                let icon = DateButtonScrollMeterIcon(.image)
                previous = self.place(icon: icon, nextTo: previous)
            }
        }
        self.finalAnchor = self.rightAnchor.constraint(equalTo: previous.rightAnchor, constant: DateButtonScrollMeterIcon.margin)
        if let finalAnchor = self.finalAnchor {
            NSLayoutConstraint.activate([finalAnchor])
        }
    }
    
    func place(icon: DateButtonScrollMeterIcon, nextTo previous: DateButtonScrollMeterIcon?) -> DateButtonScrollMeterIcon {
        self.addSubview(icon)
        icon.position = previous == nil ? 0 : previous!.position + 1
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: previous?.rightAnchor ?? self.leftAnchor, constant: DateButtonScrollMeterIcon.margin),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        return icon
    }
    
    func update(position: Int) {
        self.subviews.forEach { view in
            if let button = view as? DateButtonScrollMeterIcon {
                button.update(fill: position == button.position)
            }
        }
    }
    
    func removeAll() {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
        if let finalAnchor = self.finalAnchor {
            NSLayoutConstraint.deactivate([finalAnchor])
            self.finalAnchor = nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DateButtonScrollMeterIcon: UIImageView {
    
    var position: Int = 0
    let icon: MeterIcon
    
    static let size: CGFloat = 10
    static let margin: CGFloat = 4
    
    init(_ icon: MeterIcon) {
        self.icon = icon
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: DateButtonScrollMeterIcon.size),
            self.heightAnchor.constraint(equalToConstant: DateButtonScrollMeterIcon.size),
        ])
        self.tintColor = .frostedWhite
        self.contentMode = .scaleAspectFit
    }
    
    func update(fill: Bool) {
        let size = DateButtonScrollMeterIcon.size
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .bold)
        self.image = UIImage(systemName: "\(icon.rawValue)\(fill ? ".fill" : "")", withConfiguration: config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum MeterIcon: String {
        case upload = "camera"
        case image = "circle"
    }
    
}
