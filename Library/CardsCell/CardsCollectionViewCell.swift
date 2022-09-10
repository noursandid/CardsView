//
//  CardCollectionViewCell.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardsCollectionViewCell"
    private var carouselView: CardsView!
    weak var delegate: CardViewDelegate?
//    var cardsArray: [CardSummary] = []
//    var selectedCard: CardSummary?
//    var primaryCard: CardSummary?
//    var selectedIndex: Int = 0
//    var isCentered: Bool = false {
//        didSet {
//            if self.cardsArray.count == 1 || !self.isCentered {
//                self.carouselView.isScrollEnabled = false
//            } else {
//                self.carouselView.isScrollEnabled = true
//            }
//        }
//    }
//    fileprivate var hasTwoCardsOnly = false
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        carouselView = CardsView(frame: self.bounds)
//        carouselView.backgroundColor = .clear
//        addSubview(carouselView)
//        addCarouselViewConstraints()
//        clipsToBounds = false
//        self.backgroundColor = .clear
//        self.layer.masksToBounds = false
//
//        carouselView.didChangeItem = didChangeItem
//    }
//
//    func configureCell(card: CardSummary, isCentered: Bool) {
//        self.isCentered = isCentered
//        self.hasTwoCardsOnly = false
//        self.primaryCard = card
//        self.cardsArray = []
//        self.cardsArray.append(card)
//        for supplementary in card.supplementaryCards ?? [] {
//            self.cardsArray.append(supplementary)
//        }
//        DispatchQueue.main.async {
//            var cards: [CardView] = []
//
//            for cardSummary in self.cardsArray {
//                let cardView = CardView()
//                cardView.configureCard(cardSummary, primaryCard: self.primaryCard)
//                cardView.delegate = self.delegate
//                cardView.index = cards.count
//                cards.append(cardView)
//            }
//
//            self.carouselView.setCards(cards: cards)
//            self.carouselView.scrollToItem(at: 0, animated: false)
//            self.selectedCard = self.cardsArray.first
//        }
//    }
//    func addCarouselViewConstraints() {
//        carouselView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            carouselView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            carouselView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//            carouselView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            carouselView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
//            ])
//    }
//
//    func didChangeItem(_ index: Int) {
//        if index != selectedIndex && selectedIndex >= 0  && index >= 0 && isCentered {
//            self.selectedCard = self.cardsArray[index]
//            delegate?.didChangeCard(card: cardsArray[index])
//            selectedIndex = index
//        }
//    }
}
