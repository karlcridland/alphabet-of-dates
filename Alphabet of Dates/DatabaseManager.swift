//
//  DatabaseManager.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 25/02/2025.
//

import FirebaseDatabase
import FirebaseAuth

class DatabaseManager {
    
    private let ref: DatabaseReference = Database.database().reference()
    
    public static let shared = DatabaseManager()
    
    private init() {
        
    }
    
    func getData(for character: String, with id: String, onComplete: @escaping (DateData?) -> Void) {
        self.ref.child("dates/\(id)/alphabet/\(character.uppercased())").observe(.value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                let data = DateData(character: character, value, id: id)
                onComplete(data)
            }
            else {
                onComplete(nil)
            }
        }
    }
    
    func getID(_ onComplete: @escaping (String) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            self.ref.child("users/\(uid)/date_id").observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? String {
                    onComplete(value)
                }
            }
        }
    }
    
    func setActivity(char: String, id: String, name: String?, date: String?) {
        print([
            "name": name,
            "date": date
        ])
        self.ref.child("dates/\(id)/alphabet/\(char.uppercased())").setValue([
            "name": name,
            "date": date
        ])
    }
    
    func set(token: String?) {
        if let fcmToken = token, let uid = Auth.auth().currentUser?.uid {
            self.ref.child("users/\(uid)/fcmToken").setValue(fcmToken)
        }
    }
    
    func appendImage(id: String, char: String, image_id: String) {
        self.ref.child("dates/\(id)/alphabet/\(char)/images").observeSingleEvent(of: .value) { snapshot in
            var images = snapshot.value as? [String] ?? []
            images.append(image_id)
            self.ref.child("dates/\(id)/alphabet/\(char)/images").setValue(images)
        }
    }
    
    func remove(image button: ImageButton) {
        let path = "dates/\(button.data.id)/alphabet/\(button.data.character)/images"
        self.ref.child(path).observeSingleEvent(of: .value) { snapshot in
            let images = (snapshot.value as? [String] ?? []).filter({$0 != button.image_id})
            print(images)
            self.ref.child(path).setValue(images)
        }
    }
    
}

class DateData {
    
    let character: String
    let name: String
    let revealedOn: String
    var images: [String]
    let id: String
    
    init(character: String, _ data: [String: Any], id: String) {
        self.character = character
        self.name = data["name"] as? String ?? ""
        self.revealedOn = data["date"] as? String ?? ""
        self.images = data["images"] as? [String] ?? []
        self.id = id
    }
    
    var canReveal: Bool {
        if (self.revealedOn == "") {
            return false
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        
        guard let inputDate = dateFormatter.date(from: self.revealedOn) else {
            print("Invalid date format")
            return false
        }
        
        let today = Date()
        return today >= inputDate
    }
    
    var hasName: Bool {
        return name != ""
    }
    
    var hasDate: Bool {
        return revealedOn != ""
    }
    
}
