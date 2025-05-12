//
//  FullScreenManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 10/05/2025.
//

import UIKit

class FullScreenManager {
    
    public static let shared = FullScreenManager()
    let view: FullScreenView = FullScreenView()
    
    private init() {
        self.view.isHidden = true
    }
    
    func set(_ activity: Activity, ref: String) {
        self.view.isHidden = false
        var i = 0
        let size = UIScreen.main.bounds.size
        self.view.removeAllSubiews()
        activity.getImages { images in
            self.view.contentSize.width = CGFloat(images.count) * size.width
            images.forEach { image in
                let imageView = UIButton(frame: CGRect(origin: CGPoint(x: size.width * CGFloat(i), y: 0), size: size))
                imageView.setImage(image, for: .normal)
                imageView.addTarget(self, action: #selector(self.hide), for: .touchUpInside)
                imageView.contentMode = .scaleAspectFit
                self.view.addSubview(imageView)
                if (ImageManager.shared.getId(image) == ref) {
                    self.view.contentOffset.x = imageView.frame.minX
                }
                i += 1
            }
        }
    }
    
    @objc func hide() {
        self.view.isHidden = true
    }
    
}
