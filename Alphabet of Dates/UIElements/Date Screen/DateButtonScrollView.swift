//
//  DateButtonScrollView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit
import FirebaseStorage

class DateButtonScrollView: UIScrollView {
    
    let upload = UIButton()
    
    init() {
        super.init(frame: .zero)
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
    }
    
    func update(with data: DateData) {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
        let size = self.frame.size
        
        self.upload.frame.size = size
        self.addSubview(upload)
        
        self.contentSize.width = self.frame.width
        var images = data.images.sortImages
        if let first = data.firstImage {
            images.sort {
                if $0 == first { return true }
                if $1 == first { return false }
                return false
            }
        }
        images.enumerated().forEach { (i, id) in
            let x = size.width * CGFloat(1 + i)
            let picture = ImageButton(frame: CGRect(origin: CGPoint(x: x, y: 0), size: size), data: data, image_id: id)
            picture.clipsToBounds = true
            picture.imageView?.contentMode = .scaleAspectFill
            self.addSubview(picture)
            self.contentSize.width = picture.frame.maxX
            picture.addTarget(self, action: #selector(self.fullScreen), for: .touchUpInside)
        }
    }
    
    @objc func fullScreen(_ sender: ImageButton) {
        if let viewController = DateButtonManager.viewController {
            viewController.fullScreen.isHidden = false
            viewController.fullScreen.setImage(sender.image(for: .normal), for: .normal)
            viewController.fullScreen.trash.target = sender
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension [String: [String: String]] {
    
    var sortImages: [String] {
        var imageTimestampPairs: [(imageID: String, timestamp: String)] = []
        self.values.forEach { images in
            images.forEach { (imageID, timestamp) in
                imageTimestampPairs.append((imageID, timestamp))
            }
        }
        let sortedImageIDs = imageTimestampPairs.sorted { $0.timestamp < $1.timestamp }.map { $0.imageID }
        return sortedImageIDs
    }
    
}
