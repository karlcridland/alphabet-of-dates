////
////  FullScreenView.swift
////  Alphabet of Dates
////
////  Created by Karl Cridland on 02/05/2025.
////
//
//import UIKit
//
//class FullScreenView: UIButton {
//    
//    let trash = TrashButton()
//    
//    init() {
//        super.init(frame: UIScreen.main.bounds)
//        self.backgroundColor = .charcoal
//        self.imageView?.contentMode = .scaleAspectFit
//        self.isHidden = true
//        self.addTarget(self, action: #selector(self.hideFullScreen), for: .touchUpInside)
//        self.trash.addTarget(self, action: #selector(self.hideFullScreen), for: .touchUpInside)
//        self.addSubview(self.trash)
//        self.trash.center = CGPoint(x: self.bounds.midX, y: self.bounds.maxY - self.trash.frame.height - 10 - (DateButtonManager.viewController?.view.safeAreaInsets.bottom ?? 0))
//    }
//    
//    @objc func hideFullScreen() {
//        self.isHidden = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//class ChunkyButton: UIButton {
//    
//    init(_ icon: String) {
//        let size: CGFloat = 60
//        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
//        self.backgroundColor = .frostedWhite
//        self.tintColor = .charcoal
//        self.layer.cornerCurve = .continuous
//        self.layer.cornerRadius = 22
//        self.addTarget(self, action: #selector(self.clicked), for: .touchUpInside)
//        self.setImage(icon)
//    }
//    
//    func setImage(_ icon: String) {
//        self.setImage(UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)), for: .normal)
//    }
//    
//    @objc func clicked() {
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//class TrashButton: ChunkyButton {
//    
//    var target: ImageButton?
//    
//    init() {
//        super.init("trash")
//    }
//    
//    override func clicked() {
//        if let target = self.target {
//            DatabaseManager.shared.remove(image: target)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//class SettingsButton: ChunkyButton {
//    
//    var activitySetter: ActivitySetter?
//    
//    init() {
//        super.init("gearshape")
//    }
//    
//    override func clicked() {
//        activitySetter?.view.isHidden = !activitySetter!.view.isHidden
//        if let isHidden = self.activitySetter?.view.isHidden {
//            self.setImage(isHidden ? "gearshape" : "xmark")
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
