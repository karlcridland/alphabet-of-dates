//
//  ActivityScrollView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit


class ActivityScrollView: UIScrollView {
    
    init(size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
    }
    
    func set(_ activity: Activity) {
        activity.getImages { images in
            self.removeAllSubiews()
            images.enumerated().forEach { (i, image) in
                let imageView = ActivityImageButton(position: i + 1, size: self.frame.size, image: image)
                self.addSubview(imageView)
            }
            self.contentSize.width = self.frame.size.width * CGFloat(images.count + 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
