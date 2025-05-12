//
//  ImageViewController.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 02/05/2025.
//

import UIKit
import PhotosUI
import FirebaseStorage
import FirebaseAuth

class ImageViewController: UIViewController, PHPickerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageManager.shared.setViewController(self)
    }
    
    func showPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else {
            return
        }

        itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
            DispatchQueue.main.async {
                if let selectedImage = image as? UIImage,
                   let id = ImageManager.shared.activity?.id,
                   let char = ImageManager.shared.activity?.character {
                    if let uid = Auth.auth().currentUser?.uid {
                        ImageManager.shared.append(id: id, author: uid, image: selectedImage)
                    }
                    let image_id: String = String.generateRandomString()
                    self.uploadImageToFirebase(image: selectedImage, path: "/dates/\(id)/\(char)/\(image_id)") { result in
                        DatabaseManager.shared.appendImage(id: id, char: char, image_id: image_id)
                        ImageManager.shared.clear()
                    }
                }
            }
        })
    }
    
    func uploadImageToFirebase(image: UIImage, path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let maxFileSize: Int = 100_000
        let maxDimension: CGFloat = 200
        let resizedImage = image.resized(toMaxDimension: maxDimension)

        var compression: CGFloat = 0.8
        var imageData = resizedImage.jpegData(compressionQuality: compression)
        
        while let data = imageData, data.count > maxFileSize, compression > 0.1 {
            compression -= 0.05
            imageData = resizedImage.jpegData(compressionQuality: compression)
        }

        guard let finalImageData = imageData, finalImageData.count <= maxFileSize else {
            completion(.failure(NSError(domain: "ImageError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Image exceeds 200KB even after resizing and compression."])))
            return
        }

        let storageRef = Storage.storage().reference().child(path)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        storageRef.putData(finalImageData, metadata: metadata) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                }
            }
        }
    }
    
}
