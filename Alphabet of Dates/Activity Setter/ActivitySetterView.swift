////
////  ActivitySetterView.swift
////  Alphabet of Dates
////
////  Created by Karl Cridland on 28/02/2025.
////
//
//import UIKit
//
//class ActivitySetterView: UIButton {
//    
//    var ActivitySetter: ActivitySetter?
//    let scroll: UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
//    
//    let activity: ActivitySetterInputView = ActivitySetterInputView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 90, height: 60), placeholder: "Activity")
//    let day: ActivitySetterInputView = ActivitySetterInputView(frame: CGRect(x: 10, y: 0, width: 0, height: 60), placeholder: "DD")
//    let month: ActivitySetterInputView = ActivitySetterInputView(frame: CGRect(x: 10, y: 0, width: 0, height: 60), placeholder: "MM")
//    let year: ActivitySetterInputView = ActivitySetterInputView(frame: CGRect(x: 10, y: 0, width: 0, height: 60), placeholder: "YYYY")
//    let save: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 60))
//    
//    let activityClear: ActivitySetterClearButton = ActivitySetterClearButton()
//    let dateClear: ActivitySetterClearButton = ActivitySetterClearButton()
//    
//    init() {
//        super.init(frame: UIScreen.main.bounds)
//        self.backgroundColor = .sageGreen
//        
//        self.isHidden = true
//        self.addSubview(self.scroll)
//        self.addSubview(self.activity)
//        self.addSubview(self.day)
//        self.addSubview(self.month)
//        self.addSubview(self.year)
//        self.addSubview(self.activityClear)
//        self.addSubview(self.dateClear)
//        self.addSubview(self.save)
//        self.scroll.showsHorizontalScrollIndicator = false
//        
//        let width: CGFloat = (UIScreen.main.bounds.width - 40) / 4
//        self.day.frame.size.width = width
//        self.month.frame.size.width = width
//        self.month.frame.origin.x = self.day.frame.maxX + 10
//        self.year.frame.origin.x = self.month.frame.maxX + 10
//        
//        self.save.setTitle("save", for: .normal)
//        self.save.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
//        self.save.backgroundColor = .systemGreen
//        self.save.layer.cornerRadius = 20
//        self.save.layer.cornerCurve = .continuous
//        
//        [self.day, self.month, self.year].forEach { inputView in
//            inputView.textField.textAlignment = .center
//            inputView.textField.keyboardType = .numberPad
//        }
//        self.addTarget(self, action: #selector(self.removeKeyboard), for: .touchUpInside)
//        
//        self.activityClear.targets.append(self.activity)
//        self.dateClear.targets = [self.day, self.month, self.year]
//    }
//    
//    @objc func removeKeyboard() {
//        [self.day, self.month, self.year, self.activity].forEach { inputView in
//            inputView.textField.resignFirstResponder()
//        }
//    }
//    
//    func setLayout() {
//        if let top = DateButtonManager.viewController?.view.safeAreaInsets.top {
//            scroll.frame.origin.y = top + 10
//            activity.frame.origin.y = scroll.frame.maxY + 40
//            day.frame.origin.y = activity.frame.maxY + 10
//            month.frame.origin.y = day.frame.origin.y
//            year.frame.origin.y = day.frame.origin.y
//            year.frame.size.width = UIScreen.main.bounds.width - year.frame.origin.x - 80
//            activityClear.frame.origin.x = activity.frame.maxX + 10
//            dateClear.frame.origin.x = year.frame.maxX + 10
//            activityClear.center.y = activity.center.y
//            dateClear.center.y = year.center.y
//            save.center.x = self.center.x
//            save.frame.origin.y = year.frame.maxY + 20
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//class ActivitySetterInputView: UIButton {
//    
//    let textField: UITextField
//    
//    init(frame: CGRect, placeholder: String) {
//        self.textField = UITextField(frame: .zero)
//        super.init(frame: frame)
//        self.textField.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .frostedWhite
//        self.layer.cornerRadius = 20
//        self.layer.cornerCurve = .continuous
//        self.addSubview(self.textField)
//        self.textField.placeholder = placeholder
//        self.textField.font = .systemFont(ofSize: 18, weight: .semibold)
//        self.textField.tintColor = .sageGreen
//        NSLayoutConstraint.activate([
//            self.textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
//            self.textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
//            self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
//        ])
//    }
//    
//    var value: String {
//        return self.textField.text ?? ""
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//class ActivitySetterClearButton: UIButton {
//    
//    var targets: [ActivitySetterInputView] = []
//    
//    init() {
//        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
//        let image = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
//        self.setImage(image, for: .normal)
//        self.layer.cornerRadius = 20
//        self.layer.cornerCurve = .continuous
//        self.imageView?.tintColor = .frostedWhite
//        self.backgroundColor = .systemRed
//        self.addTarget(self, action: #selector(self.clearAll), for: .touchUpInside)
//    }
//    
//    @objc func clearAll() {
//        targets.forEach { inputView in
//            inputView.textField.text = nil
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
