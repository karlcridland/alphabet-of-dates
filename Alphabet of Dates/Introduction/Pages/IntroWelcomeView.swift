//
//  IntroWelcomeView.swift
//  Alphabet of Dates
//
//  Created by Karl Cridland on 05/06/2025.
//

import UIKit

class IntroWelcomeView: IntroductionSubview, UIScrollViewDelegate {
    
    let scroll: FunScrollView = FunScrollView()
    let icon = AuthIconView()
    
    let welcome = IntroWelcomeLabel()
    let howItWorks = IntroHowItWorksLabel()
    let onTheDate = IntroOnTheDateLabel()
    
    let examples_left: IntroExamples = IntroExamples(false)
    let examples_right: IntroExamples = IntroExamples(true)
    
    let emoji_view: EmojiGeneratorView = EmojiGeneratorView()
    
    override init() {
        super.init()
        
        self.addSubview(self.examples_left.view)
        self.addSubview(self.examples_right.view)
        self.addSubview(self.emoji_view)
        self.addSubview(self.scroll)
        
        self.scroll.addItems(self.items)
        self.setFeatures()
    }
    
    func setFeatures() {
        
        // creates a flurry of suggestions from both sides of the screen, trajectory is taken from the IntroExamples leftTrajectory boolean variable.
        
        self.scroll.append { (scrollView, y) in
            [self.examples_left, self.examples_right].enumerated().forEach { (i, examples) in
                let start: CGFloat = UIScreen.main.bounds.height * 0.7
                let dy: CGFloat = y - start
                let distance: CGFloat = examples.view.frame.width + UIScreen.main.bounds.width
                examples.view.transform = CGAffineTransform(translationX: dy * (examples.leftTrajectory ? -1 : 1), y: -dy/2)
                examples.view.update(dy / distance)
            }
        }
        
        // removes the scroll hint when the user has scrolled further than 50 pixels
        
        self.scroll.append { (scrollView, y) in
            if (y > 50) {
                UIView.animate(withDuration: 0.3) {
                    self.welcome.scrollLabel.alpha = 0
                }
            }
        }
        
        // populates the emoji generator when the application is in range
        
        self.scroll.append { scrollView, y in
            let h = UIScreen.main.bounds.height
            let dy = abs(y - (h * 2) - self.safeAreaInsets.top)
            self.emoji_view.alpha = min(1, max(0, (100 - dy)/100))
            if (y > (h * 2) - 100 && y < (h * 2) + 100) {
                let minY = self.onTheDate.frame.maxY - (2 * h) + 58
                self.emoji_view.set(frame: CGRect(x: -10, y: minY, width: self.frame.width + 20, height: h - minY - self.safeAreaInsets.bottom))
                self.emoji_view.startPopulating()
            }
            else {
                self.emoji_view.stopPopulating()
            }
        }
    }
    
    var items: [ScrollItem] {
        return [
            ScrollItem(view: self.icon, y: 20),
            ScrollItem(view: self.welcome, y: 200),
            ScrollItem(view: self.howItWorks, y: UIScreen.main.bounds.height * 1),
            ScrollItem(view: self.onTheDate, y: UIScreen.main.bounds.height * 2),
        ]
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        NSLayoutConstraint.activate([
            self.scroll.topAnchor.constraint(equalTo: self.topAnchor),
            self.scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        [self.welcome, self.howItWorks, self.onTheDate].forEach { view in
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct ScrollItem: Equatable {
    let view: UIView
    let y: CGFloat
    
    static func == (lhs: ScrollItem, rhs: ScrollItem) -> Bool {
        return lhs.view == rhs.view
    }
}

class FunScrollView: UIScrollView, UIScrollViewDelegate {
    
    var executables: [(UIScrollView, CGFloat) -> Void] = []
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        self.showsVerticalScrollIndicator = false
        self.delegate = self
        self.isPagingEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.executables.forEach { executable in
            executable(self, self.contentOffset.y + scrollView.safeAreaInsets.top)
        }
    }
    
    public func addItems(_ items: [ScrollItem]) {
        self.contentSize.height = UIScreen.main.bounds.height * CGFloat(items.count)
        items.forEach { item in
            self.addSubview(item.view)
            self.addItem(item)
        }
    }
    
    private func addItem(_ item: ScrollItem) {
        self.append { (scroll, y) in
            let dy = y - item.y
            if (y < item.y) {
                item.view.transform = CGAffineTransform.identity
            }
            else if (y >= item.y && y < item.y + 100) {
                let scale = min(max((160 - dy) / 100, 0.6), 1)
                item.view.transform = CGAffineTransform(translationX: 0, y: dy).scaledBy(x: scale, y: scale)
            }
            else if (y >= item.y + 100) {
                let scale: CGFloat = 0.6
                item.view.transform = CGAffineTransform(translationX: 0, y: dy).scaledBy(x: scale, y: scale).translatedBy(x: 0, y: (100-dy) / 2)
            }
        }
        NSLayoutConstraint.activate([
            item.view.topAnchor.constraint(equalTo: self.topAnchor, constant: item.y),
            item.view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func append(_ executable: @escaping (UIScrollView, CGFloat) -> Void) {
        self.executables.append(executable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
