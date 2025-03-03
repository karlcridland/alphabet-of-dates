//
//  ViewController.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import UIKit
import PhotosUI
import FirebaseStorage
import FirebaseAuth

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    var currentId, currentChar: String?
    let fullScreen: FullScreenView = FullScreenView()
    
    let dateSetter: DateSetter = DateSetter()
    
    let auth: Authentication = Authentication.shared
    static let manager = DateButtonManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ViewController.manager.scroll)
        self.view.sendSubviewToBack(ViewController.manager.scroll)
        DateButtonManager.viewController = self
        if (self.masterUser) {
            self.view.addSubview(self.dateSetter.view)
            self.view.addSubview(self.dateSetter.settingsButton)
        }
        self.view.addSubview(self.auth.view)
        self.view.addSubview(self.fullScreen)
        
        self.dateSetter.settingsButton.isHidden = !self.masterUser
        
//        do {
//            try Auth.auth().signOut()
//        }
//        catch {
//            
//        }
    }
    
    var masterUser: Bool {
        return Auth.auth().currentUser?.uid == "PeKvS2bDx3fQacWynvmfLg6clnF3"
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        NSLayoutConstraint.activate([
            ViewController.manager.scroll.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.safeAreaInsets.top),
            ViewController.manager.scroll.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            ViewController.manager.scroll.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            ViewController.manager.scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.safeAreaInsets.bottom),
        ])
        self.dateSetter.settingsButton.frame.origin = CGPoint(x: 10, y: self.view.frame.height - self.view.safeAreaInsets.bottom - self.dateSetter.settingsButton.frame.height - 10)
        self.dateSetter.view.setLayout()
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

        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            DispatchQueue.main.async {
                if let selectedImage = image as? UIImage,
                    let id = self.currentId,
                    let char = self.currentChar {
                    let image_id: String = self.generateRandomString()
                    self.uploadImageToFirebase(image: selectedImage, path: "/dates/\(id)/\(char)/\(image_id)") { result in
                        DatabaseManager.shared.appendImage(id: id, char: char, image_id: image_id)
                        print(result)
                    }
                }
            }
        }
    }
    
    func generateRandomString(length: Int = 12) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
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

class FullScreenView: UIButton {
    
    let trash = TrashButton()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .charcoal
        self.imageView?.contentMode = .scaleAspectFit
        self.isHidden = true
        self.addTarget(self, action: #selector(self.hideFullScreen), for: .touchUpInside)
        self.trash.addTarget(self, action: #selector(self.hideFullScreen), for: .touchUpInside)
        self.addSubview(self.trash)
        self.trash.center = CGPoint(x: self.bounds.midX, y: self.bounds.maxY - self.trash.frame.height - 10 - (DateButtonManager.viewController?.view.safeAreaInsets.bottom ?? 0))
    }
    
    @objc func hideFullScreen() {
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ChunkyButton: UIButton {
    
    init(_ icon: String) {
        let size: CGFloat = 60
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        self.backgroundColor = .frostedWhite
        self.tintColor = .charcoal
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 22
        self.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
        self.setImage(icon)
    }
    
    func setImage(_ icon: String) {
        self.setImage(UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)), for: .normal)
    }
    
    @objc func clicked() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TrashButton: ChunkyButton {
    
    var target: ImageButton?
    
    init() {
        super.init("trash")
    }
    
    override func clicked() {
        if let target = self.target {
            DatabaseManager.shared.remove(image: target)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SettingsButton: ChunkyButton {
    
    var dateSetter: DateSetter?
    
    init() {
        super.init("gearshape")
    }
    
    override func clicked() {
        dateSetter?.view.isHidden = !dateSetter!.view.isHidden
        if let isHidden = self.dateSetter?.view.isHidden {
            self.setImage(isHidden ? "gearshape" : "xmark")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIImage {
    func resized(toMaxDimension maxDimension: CGFloat) -> UIImage {
        let aspectRatio = size.width / size.height
        var newSize: CGSize

        if size.width > size.height {
            newSize = CGSize(width: maxDimension, height: maxDimension / aspectRatio)
        } else {
            newSize = CGSize(width: maxDimension * aspectRatio, height: maxDimension)
        }

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
