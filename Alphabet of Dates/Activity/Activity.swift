//
//  Activity.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 07/05/2025.
//

import UIKit

// Creates an instance of an activity.

class Activity {
    
    private let data: DateData
    
    let view: ActivityView
    let id, character: String
    let canReveal: Bool
    
    private var saved_images: [String: UIImage] = [:]
    
    init(_ data: DateData) {
        self.data = data
        self.id = data.id
        self.character = data.character
        self.canReveal = data.canReveal
        let position: Int = String.alphabet.firstIndex(of: data.character) ?? 0
        self.view = ActivityView(position)
        self.view.set(self)
    }
    
    func getImages(onComplete: @escaping ([UIImage]) -> Void) {
        self.data.images.sortImages().forEach { ref in
            if (self.saved_images[ref] == nil) {
                ref.downloadImage(id: self.id, character: self.character) { image in
                    self.saved_images[ref] = image
                    onComplete(self.images_sorted)
                }
            }
        }
        onComplete(self.images_sorted)
    }
    
    func getImageRef(_ image: UIImage) -> String? {
        if let first = self.saved_images.first(where: {$0.value == image}) {
            return first.key
        }
        return nil
    }
    
    private var images_sorted: [UIImage] {
        var results: [UIImage] = []
        self.data.images.sortImages(self.data.firstImage).forEach { ref in
            if let image = self.saved_images[ref] {
                results.append(image)
            }
        }
        return results
    }
    
    @objc func uploadPhotoClicked() {
    }
    
    @objc func fullscreenClicked() {
    }
    
    @objc func removeImageClicked() {
    }
    
    @objc func favouriteImageClicked() {
    }
    
}
