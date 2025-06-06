//
//  Introduction.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

class Introduction {
    
    var id: String?
    var isMainUser: Bool = false
    
    let view: IntroductionView = IntroductionView()
    
    init() {
        var previous: IntroductionSubview?
        self.view.pages.forEach { view in
            view.previousPage = previous
            previous?.nextPage = view
            previous = view
        }
        self.getID { name in
            if !self.isMainUser {
                self.createSession {
                    
                }
            }
        }
    }
    
    func createSession(_ onComplete: @escaping () -> Void) {
        DatabaseManager.shared.createID() { id in
            self.id = id
            onComplete()
        }
    }
    
    func getID(_ onComplete: @escaping (String?) -> Void) {
        DatabaseManager.shared.getID { id in
            self.id = id
            self.isMainUser = id != nil
            if let id = id {
                DatabaseManager.shared.getMainName(for: id) { name in
                    onComplete(name)
                }
            }
            else {
                onComplete(nil)
            }
        }
    }
    
}
