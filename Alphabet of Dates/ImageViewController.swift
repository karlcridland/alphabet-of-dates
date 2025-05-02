//
//  ImageViewController.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 02/05/2025.
//

import UIKit
import PhotosUI
import FirebaseStorage

class ImageViewController: UIViewController, PHPickerViewControllerDelegate {
    
    var currentId, currentChar: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // Set to 0 for unlimited selection
        config.filter = .images // Only show images
        
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
                   let id = self.currentId,
                   let char = self.currentChar {
                    let image_id: String = String.generateRandomString()
                    self.uploadImageToFirebase(image: selectedImage, path: "/dates/\(id)/\(char)/\(image_id)") { result in
                        DatabaseManager.shared.appendImage(id: id, char: char, image_id: image_id)
                        print(result)
                    }
                }
            }
        })
    }
    
    func uploadImageToFirebase(image: UIImage, path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let maxFileSize: Int = 100_000 // 200KB
        let maxDimension: CGFloat = 200 // Further reduce size if needed

        // Step 1: Resize image to smaller dimensions
        let resizedImage = image.resized(toMaxDimension: maxDimension)
        
        var compression: CGFloat = 0.8 // Start with some compression
        var imageData = resizedImage.jpegData(compressionQuality: compression)
        
        // Step 2: Reduce quality in finer steps (0.05) until it's under 200KB
        while let data = imageData, data.count > maxFileSize, compression > 0.1 {
            compression -= 0.05
            imageData = resizedImage.jpegData(compressionQuality: compression)
        }

        // Step 3: Ensure final image data is within limits
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

            // Fetch the download URL
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
