//
//  ImageButton.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/05/2025.
//

import UIKit
import FirebaseStorage


class ImageButton: UIButton {
    
    static var images: [String: UIImage] = [:]
    
    let data: DateData
    let image_id: String
    let activity = UIActivityIndicatorView(style: .medium)

    init(frame: CGRect, data: DateData, image_id: String) {
        self.data = data
        self.image_id = image_id
        super.init(frame: frame)
        self.activity.startAnimating()
        self.activity.frame = CGRect(origin: .zero, size: self.frame.size)
        self.backgroundColor = .frostedWhite
        self.setImageFromFirebase(path: "dates/\(data.id)/\(data.character)/\(image_id)")
    }
    
    func setImageFromFirebase(path: String) {
        if let image = ImageButton.images[path] {
            self.setImage(image, for: .normal)
            return
        }
        let storageRef = Storage.storage().reference().child(path)

        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    ImageButton.images[path] = image
                    self.setImage(image, for: .normal)
                }
            }.resume()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
