//
//  EmojiGeneratorView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 06/06/2025.
//

import UIKit

class EmojiGeneratorView: UIView {
    
    let emojis: [String] = ["📸", "📷", "🥰"]
    let numberOfEmojis: Int = 70
    var timer: Timer?
    
    private let EMOJI_LIFETIME: TimeInterval = 3.0
    
    private var hasSetFrame: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(size: CGSize) {
        self.init(frame: .zero)
    }
    
    func startPopulating() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: self.EMOJI_LIFETIME / Double(self.numberOfEmojis), repeats: true) { [weak self] _ in
            self?.tryAddEmoji()
        }
    }
    
    func stopPopulating() {
        timer?.invalidate()
        timer = nil
    }
    
    private func tryAddEmoji() {
        guard subviews.count < numberOfEmojis else { return }
        if (subviews.count < 10) {
            for _ in 0 ..< 2 * (numberOfEmojis / 3) {
                addRandomEmoji()
            }
        }
        addRandomEmoji()
    }
    
    private func addRandomEmoji() {
        let emoji = emojis.randomElement()!
        let label = UILabel()
        label.text = emoji
        label.font = .systemFont(ofSize: 50)
        label.sizeToFit()
        
        let maxX = bounds.width - label.bounds.width
        let maxY = bounds.height - label.bounds.height
        let randomX = CGFloat.random(in: 0...maxX)
        let randomY = CGFloat.random(in: 0...maxY)
        label.frame.origin = CGPoint(x: randomX, y: randomY)
        
        label.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        label.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            label.transform = CGAffineTransform.identity
            label.alpha = 1
        }
        
        addSubview(label)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.EMOJI_LIFETIME) { [weak label] in
            UIView.animate(withDuration: 0.2) {
                label?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                label?.alpha = 0
            } completion: { _ in
                label?.removeFromSuperview()
            }
        }
    }
    
    func set(frame: CGRect) {
        if (!self.hasSetFrame) {
            self.frame = frame
            self.hasSetFrame = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
