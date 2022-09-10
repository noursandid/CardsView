//
//  CardCarouselCollectionView.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit
protocol CardViewDelegate: class {
    func didSelectCard()
    func didChangeCard()
}

class CardCarouselCollectionView: UICollectionView {
    
//    var flowLayout: SJCenterFlowLayout {
//        return self.collectionViewLayout as? SJCenterFlowLayout ?? SJCenterFlowLayout()
//    }
//    weak var cardViewDelegate: CardViewDelegate?
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        commonInit()
//    }
//    
//    override func layoutSubviews() {
//        let width = self.frame.width * 0.8
//        flowLayout.itemSize = CGSize(
//            width: width,
//            height: width/1.4
//        )
//        flowLayout.scrollDirection = .horizontal
//        
//        super.layoutSubviews()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//    func commonInit() {
//        register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: CardsCollectionViewCell.identifier)
//        flowLayout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.8,
//                                                                     sideItemAlpha: 0.9,
//                                                                     sideItemShift: 0.0)
//        collectionViewLayout = flowLayout
//        showsHorizontalScrollIndicator = false
//        decelerationRate = .fast
//        dataSource = self
//        delegate = self
//    }
//}
//
//extension CardCarouselCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cards.count + 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == cards.count {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewCardCollectionViewCell.identifier,
//                                                          for: indexPath) as? AddNewCardCollectionViewCell
//            cell?.cardAction = newCardAction
//            return cell!
//        } else {
//            let cell = collectionView
//                .dequeueReusableCell(withReuseIdentifier: CardsCollectionViewCell.identifier,
//                                     for: indexPath) as? CardsCollectionViewCell
//            cell?.delegate = cardViewDelegate
//            cell?.configureCell(card: cards[indexPath.item], isCentered: false)
//            cell?.backgroundColor = .clear
//            return cell!
//        }
//    }
}
