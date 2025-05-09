//
//  String.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 02/05/2025.
//

import UIKit
import FirebaseStorage

extension String {
    
    static func generateRandomString(length: Int = 12) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
    var toDate: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.timeZone = TimeZone.current
        guard let date = inputFormatter.date(from: self) else { return nil }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        outputFormatter.dateFormat = "d MMMM yyyy"
        let day = Calendar.current.component(.day, from: date)
        let suffix = daySuffix(for: day)
        return "\(day)\(suffix) \(outputFormatter.string(from: date).dropFirst(2))".replacingOccurrences(of: "202", with: "'2").replacingOccurrences(of: "  ", with: " ")
    }
    
    private func daySuffix(for day: Int) -> String {
        switch day {
        case 11, 12, 13: return "th" // Special case for 11-13
        default:
            switch day % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
    }
    
    static var alphabet: [String] {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(separator: "").map({$0.uppercased()})
    }
    
    func downloadImage(id: String, character: String, _ onComplete: @escaping (UIImage) -> Void) {
        let path = "dates/\(id)/\(character)/\(self)"
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
                    onComplete(image)
                }
            }.resume()
        }
    }
    
}
