//
//  ActivityScrollView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit


class ActivityScrollView: UIScrollView {
    
    let home: ActivityHomeButton
    
    init(size: CGSize) {
        self.home = ActivityHomeButton(size: size)
        super.init(frame: CGRect(origin: .zero, size: size))
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.layer.cornerCurve = .continuous
    }
    
    func set(_ activity: Activity) {
        self.home.activity = activity
        self.home.label.text = activity.canReveal ? activity.title : ""
        self.home.date.text = activity.date
        self.home.dateWrapper.isHidden = activity.date == ""
        activity.getImages { images in
            self.removeAllSubiews()
            self.addSubview(self.home)
            images.enumerated().forEach { (i, image) in
                if let id = ImageManager.shared.getId(image) {
                    let imageView = ActivityImageButton(position: i + 1, size: self.frame.size, id: id, image: image)
                    imageView.activity = activity
                    self.addSubview(imageView)
                }
            }
            self.contentSize.width = self.frame.size.width * CGFloat(images.count + 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
