//
//  Activity.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit
import FirebaseAuth

// Creates an instance of an activity.

class Activity {
    
    private var data: DateData
    
    let view: ActivityView
    let id, character, title, date: String
    let canReveal: Bool
    
    init(_ data: DateData) {
        self.data = data
        self.title = data.name
        self.date = data.revealedOn.toDate ?? data.revealedOn
        self.id = data.id
        self.character = data.character
        self.canReveal = data.canReveal
        let position: Int = String.alphabet.firstIndex(of: data.character) ?? 0
        self.view = ActivityView(position)
        self.view.set(self)
    }
    
    func update() {
        self.view.scroll.set(self)
    }
    
    func getAuthor(_ ref: String) -> String? {
        var result: String?
        self.data.images.forEach { (author, images) in
            if (images.keys.contains(ref)) {
                result = author
            }
        }
        return result
    }
    
    func getImages(onComplete: @escaping ([UIImage]) -> Void) {
        self.data.images.sortImages().forEach { ref in
            if (ImageManager.shared.getImage(ref) == nil) {
                if let uid = getAuthor(ref) {
                    ref.downloadImage(id: self.id, character: self.character, uid: uid) { image in
                        onComplete(self.images_sorted)
                    }
                }
            }
        }
        onComplete(self.images_sorted)
    }
    
    private var images_sorted: [UIImage] {
        var results: [UIImage] = []
        self.data.images.sortImages(self.data.firstImage).forEach { ref in
            if let image = ImageManager.shared.getImage(ref) {
                results.append(image)
            }
        }
        self.view.scroll.home.photoCount.update(quantity: results.count)
        return results
    }
    
    @objc func uploadPhotoClicked() {
        ImageManager.shared.takePhoto(self)
    }
    
    @objc func fullscreenClicked() {
        if let selected = self.view.optionButton.selected_image {
            FullScreenManager.shared.set(self, ref: selected)
        }
    }
    
    @objc func removeImageClicked() {
        if let selected = self.view.optionButton.selected_image,
           let uid = Auth.auth().currentUser?.uid,
            let image_uid = ImageManager.shared.getAuthor(selected), uid == image_uid {
            DatabaseManager.shared.remove(image: selected, id: self.id, character: self.character)
            self.data.images[uid]?.removeValue(forKey: selected)
            self.view.set(self)
        }
    }
    
    @objc func favouriteImageClicked() {
    }
    
}
