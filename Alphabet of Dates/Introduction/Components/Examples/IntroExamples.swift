//
//  IntroExamples.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroExamples {
    
    var examples: [IntroExampleView] = []
    let view: IntroExamplesView = IntroExamplesView()
    
    let leftTrajectory: Bool
    
    init(_ leftTrajectory: Bool) {
        self.leftTrajectory = leftTrajectory
        let data = IntroExampleManager.shared.get()
        let angle: CGFloat = CGFloat(360.0) / CGFloat(data.count)
        data.enumerated().forEach { (i, example) in
            self.examples.append(IntroExampleView(example, CGFloat(i) * angle))
        }
        self.view.center = CGPoint(x: leftTrajectory ? UIScreen.main.bounds.width + 100 : -100, y: UIScreen.main.bounds.midY + 200)
        self.view.display(examples: self.examples)
    }
    
}

class IntroExampleManager {
    
    public static let shared = IntroExampleManager()
    
    var examples: [IntroExample] = [
        IntroExample("Kayaking", "🛶"),
        IntroExample("Bowling", "🎳"),
        IntroExample("Mini Golf", "⛳️"),
        IntroExample("Concert", "🎤"),
        IntroExample("Zoo", "🐘"),
        IntroExample("Dinner", "🍝"),
        IntroExample("Quiz Night", "🤔"),
        IntroExample("Games Night", "🎲"),
        IntroExample("Road Trip", "🚗"),
        IntroExample("Hike", "🥾"),
        IntroExample("Yoga", "🧘🏼‍♀️"),
        IntroExample("Vineyard", "🍷"),
        IntroExample("Xmas Market", "🎄"),
        IntroExample("Strawberry Picking", "🍓"),
        IntroExample("Theatre", "🎭"),
        IntroExample("Ice Cream", "🍦"),
        IntroExample("Coffee Date", "☕️"),
    ]
    
    private init() {
        
    }
    
    func get() -> [IntroExample] {
        var results: [IntroExample] = []
        while results.count < 7 && examples.count != 0 {
            self.examples.shuffle()
            if let example = self.examples.popLast() {
                results.append(example)
            }
            print(results.count, examples.count)
        }
        return results
    }
    
}



