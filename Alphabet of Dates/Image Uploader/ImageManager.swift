//
//  ImageManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 01/05/2025.
//

import UIKit
import FirebaseAuth

class ImageManager {
    
    public static let shared = ImageManager()
    private var viewController: ImageViewController?
    
    var activity: Activity?
    
    var images: [ImageData] = []
    
    private init() {
        
    }
    
    func setViewController(_ viewController: ImageViewController) {
        self.viewController = viewController
    }
    
    func takePhoto(_ id: String, _ character: String) {
        viewController?.showPhotoPicker()
    }
    
    func takePhoto(_ activity: Activity) {
        self.activity = activity
        viewController?.showPhotoPicker()
    }
    
    func clear() {
        self.activity?.update()
        self.activity = nil
    }
    
    func append(id: String, author: String, image: UIImage) {
        if (!self.images.contains(where: {$0.id == id})) {
            self.images.append(ImageData(id: id, author: author, image: image))
        }
    }
    
    func getImage(_ ref: String) -> UIImage? {
        if let data = self.images.first(where: {$0.id == ref}) {
            return data.image
        }
        return nil
    }
    
    func getAuthor(_ image: UIImage) -> String? {
        if let data = self.images.first(where: {$0.image == image}) {
            return data.author
        }
        return nil
    }
    
    func getAuthor(_ ref: String) -> String? {
        if let data = self.images.first(where: {$0.id == ref}) {
            return data.author
        }
        return nil
    }
    
    func getId(_ image: UIImage) -> String? {
        if let data = self.images.first(where: {$0.image == image}) {
            return data.id
        }
        return nil
    }
    
    func isMyImage(_ ref: String) -> Bool {
        let author = self.getAuthor(ref)
        return author == Auth.auth().currentUser?.uid
    }
    
}

struct ImageData {
    
    let id, author: String
    let image: UIImage
    
}
