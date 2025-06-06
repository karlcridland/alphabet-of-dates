//
//  IntroExampleView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class IntroExampleView: IntroInfoView {
    
    let trajectory: Trajectory
    
    let random: CGFloat = CGFloat.random(in: 0 ..< .pi)
    
    init(_ activity: String, _ emoji: String, _ angle: CGFloat) {
        self.trajectory = Trajectory(angle: angle)
        super.init(title: "\(activity.first?.uppercased() ?? "") for \(emoji)", subtitle: activity, margin: 10, gap: 5)
        self.commonInit()
    }
    
    init(_ example: IntroExample, _ angle: CGFloat) {
        self.trajectory = Trajectory(angle: angle)
        super.init(title: "\(example.activity.first?.uppercased() ?? "") for \(example.activity)", subtitle: "\(example.emoji)\(example.emoji)\(example.emoji)\(example.emoji)\(example.emoji)", margin: 12, gap: 2)
        self.commonInit()
    }
    
    func commonInit() {
        self.body.textAlignment = .center
//        self.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func update(_ variance: CGFloat) {
        let angle: CGFloat = (-.pi / 4) + (variance / 2) + self.random
        self.transform = CGAffineTransform(rotationAngle: angle)
        self.center = self.trajectory.get(variance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct IntroExample {
    let activity, emoji: String
    init(_ activity: String, _ emoji: String) {
        self.activity = activity
        self.emoji = emoji
    }
}

struct Trajectory {
    
    let start, end: CGPoint
    
    init(angle: CGFloat, center: CGPoint = CGPoint(x: 100, y: 100)) {
        
        func pointFromCenter(angleDegrees: CGFloat, distance: CGFloat) -> CGPoint {
            let radians = angleDegrees * .pi / 180
            let dx = cos(radians) * distance
            let dy = sin(radians) * distance
            return CGPoint(x: dx, y: dy)
        }
        
        let startOffset = pointFromCenter(angleDegrees: angle, distance: 10 + CGFloat.random(in: 0 ..< 10))
        let endOffset = pointFromCenter(angleDegrees: angle, distance: 200 + CGFloat.random(in: 0 ..< 100))
        
        self.start = CGPoint(x: center.x + startOffset.x, y: center.y + startOffset.y)
        self.end = CGPoint(x: center.x + endOffset.x, y: center.y + endOffset.y)
    }
    
    func get(_ variance: CGFloat) -> CGPoint {
        let clamped = max(0, min(1, variance))
        let x = start.x + (end.x - start.x) * clamped
        let y = start.y + (end.y - start.y) * clamped
        return CGPoint(x: x, y: y)
    }
    
}

