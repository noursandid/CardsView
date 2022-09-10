//
//  CardsView.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

open class BaseCardView: UIView {
    fileprivate var heightConstraint: NSLayoutConstraint?
    fileprivate var topConstraint: NSLayoutConstraint?
    fileprivate var leadingConstraint: NSLayoutConstraint?
    fileprivate var centerXConstraint: NSLayoutConstraint?
    fileprivate var bottomConstraint: NSLayoutConstraint?
    fileprivate var index: Int = 0
    
    fileprivate func activateConstraints() {
        let constraints: [NSLayoutConstraint] = [heightConstraint,
                                                 topConstraint, bottomConstraint, leadingConstraint, centerXConstraint]
            .compactMap({$0})
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func removeConstraints() {
        let constraints = [heightConstraint,
                           topConstraint, leadingConstraint,
                           centerXConstraint, bottomConstraint]
            .compactMap({$0})
        removeConstraints(constraints)
    }
    
    public func didBecomeInactive() {
        //overriden
    }
    public func didBecomActive() {
        //overriden
    }
}
open class UIPanDirectionGestureRecognizer: UIPanGestureRecognizer {
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .began {
            let vel = velocity(in: self.view)
            if abs(vel.x) > abs(vel.y) {
                state = .cancelled
            }
        }
    }
}

public class CardsView: UIView {
    
    private var cards: [BaseCardView] = []
    private var tapGestures: [UITapGestureRecognizer] = []
    private var frames: [CGRect] = []
    private var isAnimating: Bool = false
    
    /** number showing how fast the user should scroll to rotate the cards
     default: 800
     */
    public var velocitySensibility: CGFloat = 800
    /** step length while panning
        e.g: while panning, every 20px the cards should rotate
     default: 20
     */
    public var panThreshold: Int = 20
    /** top space that will be shown from the cards in the back
     P.S: This value might change if the cards can't fit in the view frame
     default: 22
     */
    public var maximumInterItemSpacing: CGFloat = 22 {
           didSet {
               self.setCards(cards: self.cards)
           }
       }
    /** left and right padding
     default: 20
     */
    public var padding: CGFloat = 20 {
        didSet {
            self.setCards(cards: self.cards)
        }
    }
    /** duration of the rotation animation
     default: 0.5
     */
    public var animationDuration: Double = 0.5
    /** the ability of the user to scroll and rotate the cards
     default: true
     */
    public var isScrollEnabled: Bool = true
    /** did Tap on the card at index*/
    public var didSelectItem: ((_ index: Int) -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let panGesture = UIPanDirectionGestureRecognizer(target: self,
                                                         action: #selector(panGestureHandler(panGesture:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func panGestureHandler(panGesture: UIPanGestureRecognizer) {
        if isScrollEnabled {
            let step = Int(panGesture.translation(in: self).y) % panThreshold
            let velocity = panGesture.velocity(in: self).y
            if step == -panThreshold+1 || velocity < -velocitySensibility {
                self.animateViews(index: cards.count-1)
            } else if step == panThreshold-1 || velocity > velocitySensibility {
                self.animateUp()
            }
        }
    }
    
    private func resetViews() {
        removeAllCards()
        tapGestures = []
        frames = []
    }
    
    private func removeAllCards() {
        for card in cards {
            for gesture in card.gestureRecognizers ?? [] {
                card.removeGestureRecognizer(gesture)
            }
            card.removeConstraints()
            card.removeFromSuperview()
        }
        self.cards = []
    }
    
    public func setCards(cards: [BaseCardView]) {
        var shouldReload = false
        resetViews()
        self.cards = cards
        for index in 0..<self.cards.count {
            let cardFrame = getFrame(index: index)
            let card = initialize(index: index, frame: cardFrame)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCard(tapGesture:)))
            tapGesture.cancelsTouchesInView = true
            card.addGestureRecognizer(tapGesture)
            sendSubviewToBack(card)
            self.tapGestures.append(tapGesture)
            self.frames.append(card.frame)
            if cardFrame.origin.y < 0 {
                shouldReload = true
            }
        }
        resetZPositions()
        if shouldReload {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeAllCards()
                self.maximumInterItemSpacing -= 1
                self.setCards(cards: cards)
            }
        } else {
            notifyActivity()
        }
    }
    
    private func initialize(index: Int, frame: CGRect) -> BaseCardView {
        let card = self.cards[index]
        UIView.performWithoutAnimation {
            
            card.index = index
            addSubview(card)
            card.translatesAutoresizingMaskIntoConstraints = false
            card.heightConstraint = card.heightAnchor.constraint(equalToConstant: frame.height)
            card.topConstraint = card.topAnchor.constraint(equalTo: topAnchor, constant: frame.origin.y)
            card.bottomConstraint = card.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
            card.leadingConstraint = card.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                   constant: frame.origin.x)
            card.centerXConstraint = card.centerXAnchor.constraint(equalTo: centerXAnchor)
            card.heightConstraint?.priority = .defaultHigh
            card.activateConstraints()
            card.clipsToBounds = true
            self.layoutIfNeeded()
        }
        return card
    }
    
    @objc func didTapCard(tapGesture: UITapGestureRecognizer) {
        if let tapIndex = tapGestures.firstIndex(of: tapGesture) {
            animateViews(index: tapIndex)
            didSelectItem?(self.cards[tapIndex].index)
        }
    }
    
    private func animateViews(index: Int) {
        if !isAnimating {
            self.isAnimating = true
            let card = cards[index]
            let tapGesture = tapGestures[index]
            
            DispatchQueue.main.async {
                let animation = CABasicAnimation(keyPath: "zPosition")
                animation.fromValue = card.layer.zPosition
                animation.toValue = CGFloat(self.cards.count+3)
                animation.duration = self.animationDuration
                card.layer.add(animation, forKey: "zPosition")
                card.layer.zPosition = CGFloat(self.cards.count+3)
            }
            UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
                self.setFrame(frame: self.frames[0], card: card)
                if index < self.cards.count {
                    for index in 0..<index {
                        let movingCard = self.cards[index]
                        self.setFrame(frame: self.frames[index+1], card: movingCard)
                    }
                }
            }) { _ in
                for index in stride(from: index-1, through: 0, by: -1) {
                    self.cards[index+1] = self.cards[index]
                    self.tapGestures[index+1] = self.tapGestures[index]
                }
                self.cards[0] = card
                self.tapGestures[0] = tapGesture
                self.resetZPositions()
                self.didSelectItem?(self.cards[0].index)
                self.isAnimating = false
                self.notifyActivity()
            }
        }
    }
    
    private func animateUp() {
        if !isAnimating {
            self.isAnimating = true
            let card = self.cards[0]
            let tapGesture = self.tapGestures[0]
            
            DispatchQueue.main.async {
                let animation = CABasicAnimation(keyPath: "zPosition")
                animation.fromValue = card.layer.zPosition
                animation.toValue = CGFloat(-10)
                animation.duration = self.animationDuration
                card.layer.add(animation, forKey: "zPosition")
                card.layer.zPosition = CGFloat(-10)
            }
            UIView.animate(withDuration: animationDuration) {
                self.setFrame(frame: self.frames[self.cards.count-1], card: card)
                for index in 1..<self.cards.count {
                    let movingCard = self.cards[index]
                    self.setFrame(frame: self.frames[index-1], card: movingCard)
                }
            } completion: { _ in
                for index in stride(from: self.cards.count-1, to: 0, by: -1) {
                    let invertedIndex = self.cards.count-1-index
                    self.cards[invertedIndex] = self.cards[invertedIndex+1]
                    self.tapGestures[invertedIndex] = self.tapGestures[invertedIndex+1]
                    self.bringSubviewToFront(self.cards[index])
                }
                self.cards[self.cards.count-1] = card
                self.tapGestures[self.cards.count-1] = tapGesture
                self.resetZPositions()
                self.didSelectItem?(self.cards[0].index)
                self.isAnimating = false
                self.notifyActivity()
            }
        }
    }
    
    public func scrollToItem(at index: Int, animated: Bool) {
        let animationDurationCopy = animationDuration
        if !animated {
            animationDuration = 0
        }
        self.animateViews(index: index)
        animationDuration = animationDurationCopy
    }
    
    private func resetZPositions() {
        for index in 0..<cards.count {
            cards[index].layer.zPosition = CGFloat(cards.count - index)
        }
    }
    
    private func getFrame(index: Int) -> CGRect {
        let cardHeight = bounds.height * 3 / 4
        let cardWidth = (bounds.width-padding) / ((CGFloat(index+1)+5)/6)
        let x = (bounds.width/2) - (cardWidth/2)
        var y: CGFloat = 0
        if index == 0 {
            let spaceDown = (CGFloat(self.cards.count-1) * self.maximumInterItemSpacing)/2
            y = min(CGFloat((bounds.height/2) - (cardHeight/2) + spaceDown), bounds.height - cardHeight)
        } else {
            y = CGFloat(self.cards[index-1].frame.origin.y - maximumInterItemSpacing)
        }
        return CGRect(x: x, y: y, width: cardWidth, height: cardHeight)
    }
    
    private func setFrame(frame: CGRect, card: BaseCardView) {
        card.heightConstraint?.constant = frame.height
        card.topConstraint?.constant = frame.origin.y
        card.leadingConstraint?.constant = frame.origin.x
        self.layoutIfNeeded()
    }
    
    private func notifyActivity() {
        self.cards.first?.didBecomActive()
        guard self.cards.count > 0 else { return }
        for index in 1..<self.cards.count {
            self.cards[index].didBecomeInactive()
        }
    }
}
