//
//  ActivityImageButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class ActivityImageButton: ActivityButton {
    
    let picture: UIImageView = UIImageView()
    
    init(position: Int, size: CGSize, image: UIImage) {
        super.init(position: position, size: size)
        self.picture.frame.size = size
        self.picture.image = image
        self.picture.isUserInteractionEnabled = false
        self.picture.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.addSubview(picture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
