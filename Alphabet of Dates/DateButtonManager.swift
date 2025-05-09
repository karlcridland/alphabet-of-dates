////
////  DateButtonManager.swift
////  Alphabet of Dates
////
////  Created by Karl Cridland on 25/02/2025.
////
//
//import UIKit
//
//class DateButtonManager {
//    
//    var id: String?
//    let scroll: UIScrollView = UIScrollView()
//    static var viewController: ViewController?
//    var buttons: [DateButton] = []
//    
//    init() {
//        self.scroll.translatesAutoresizingMaskIntoConstraints = false
//        self.scroll.clipsToBounds = false
//        let chars: [String] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ12".split(separator: "").map({String($0)})
//        chars.forEach { character in
//            let button = DateButton(String(character), Int(character.position))
//            self.buttons.append(button)
//            self.scroll.addSubview(button)
//        }
//        if let y = self.scroll.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last?.frame.maxY {
//            self.scroll.contentSize.height = y + DateButton.margin
//        }
//    }
//    
//    func update() {
//        DatabaseManager.shared.getID { id in
//            self.id = id
//            self.buttons.forEach { button in
//                button.update(with: id)
//            }
//        }
//    }
//    
//}
