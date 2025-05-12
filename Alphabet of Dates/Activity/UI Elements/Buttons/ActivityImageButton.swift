//
//  ActivityImageButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 09/05/2025.
//

import UIKit

class ActivityImageButton: ActivityButton {
    
    let picture: UIImageView = UIImageView()
    let id: String
    
    init(position: Int, size: CGSize, id: String, image: UIImage) {
        self.id = id
        super.init(position: position, size: size)
        self.picture.frame.size = size
        self.picture.image = image
        self.picture.isUserInteractionEnabled = false
        self.picture.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.addSubview(picture)
    }
    
    override func tapped() {
        if let optionButton = self.activity?.view.optionButton {
            optionButton.selected_image = self.id
            optionButton.addImage.disable = false
            optionButton.fullScreen.disable = false
            optionButton.favourite.disable = false
            optionButton.delete.disable = !ImageManager.shared.isMyImage(id)
            super.tapped()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
