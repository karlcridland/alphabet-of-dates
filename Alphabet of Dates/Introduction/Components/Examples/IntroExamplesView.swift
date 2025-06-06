//
//  IntroExamplesView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroExamplesView: UIView {
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        self.isUserInteractionEnabled = false
    }
    
    func display(examples: [IntroExampleView]) {
        examples.forEach { exampleView in
            self.addSubview(exampleView)
            exampleView.center = exampleView.trajectory.start
            print(exampleView.center)
        }
    }
    
    var currentLocation: String {
        var centres: [CGPoint] = []
        self.examples.forEach { view in
            centres.append(view.center)
            view.update(0)
        }
        return centres.map({"\($0)"}).joined(separator: ", ")
    }
    
    func update(_ variance: CGFloat) {
        self.examples.forEach { exampleView in
            exampleView.update(variance)
        }
    }
    
    var examples: [IntroExampleView] {
        var results: [IntroExampleView] = []
        self.subviews.filter({$0 is IntroExampleView}).forEach { view in
            if let result = view as? IntroExampleView {
                results.append(result)
            }
        }
        return results
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
