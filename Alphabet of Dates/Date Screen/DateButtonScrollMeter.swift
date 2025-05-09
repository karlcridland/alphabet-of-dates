////
////  DateButtonScrollMeter.swift
////  Alphabet of Dates
////
////  Created by Karl Cridland on 26/02/2025.
////
//
//import UIKit
//
//class DateButtonScrollMeter: NSObject, UIScrollViewDelegate {
//    
//    let view: DateButtonScrollMeterView = DateButtonScrollMeterView()
//    let scroll: DateButtonScrollView = DateButtonScrollView()
//    let blur: UIVisualEffectView = UIVisualEffectView()
//    
//    var id, char: String?
//    
//    var touches: Int = 0
//    
//    override init() {
//        super.init()
//        self.scroll.delegate = self
//        self.scroll.upload.addTarget(self, action: #selector(self.uploadPhoto), for: .touchUpInside)
//    }
//    
//    func update(with data: DateData? = nil) {
//        if let data = data {
//            self.scroll.update(with: data)
//            self.view.update(with: data.images)
//        }
//        self.scrollViewDidEndDecelerating(self.scroll)
//    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.touches += 1
//        UIView.animate(withDuration: 0.25) {
//            self.view.alpha = 1
//        }
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.frame.width > 0) {
//            let y: CGFloat = scrollView.contentOffset.x / scrollView.frame.width
//            self.blur.alpha = y
//        }
//        else {
//            self.blur.alpha = 0
//        }
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if (scrollView.frame.width > 0) {
//            let y: Int = Int(scrollView.contentOffset.x / scrollView.frame.width)
//            self.view.update(position: y)
//        }
//        else {
//            self.view.update(position: 0)
//        }
//        let current = self.touches
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
//            if (current == self.touches) {
//                UIView.animate(withDuration: 0.25) {
//                    self.view.alpha = 0
//                }
//            }
//        }
//    }
//    
//    @objc func uploadPhoto() {
//        if let viewController = DateButtonManager.viewController,
//            let id = id {
//            viewController.currentId = id
//            viewController.currentChar = self.char
//            viewController.showPhotoPicker()
//        }
//    }
//    
//}
