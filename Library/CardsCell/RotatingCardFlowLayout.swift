//
//  RotatingCardFlowLayout.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

//open class RotatingCardFlowLayout: UICollectionViewFlowLayout {
//    
//    public var hasStackEffect: Bool = true
//    public var isPagingEnabled: Bool = true
//    private var firstSetupDone: Bool = false
//    private var cellHeight: CGFloat = 0
//    private let scaleRatio: CGFloat = 0.05
//    
//    // MARK: - Override
//    
//    open override func prepare() {
//        super.prepare()
//        
//        guard firstSetupDone else {
//            setup()
//            firstSetupDone = true
//            return
//        }
//    }
//    
//    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//    
//    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
//                                           withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        // If the property `isPagingEnabled` is set to false, we don't enable paging and thus return the current contentoffset.
//        guard isPagingEnabled else {
//            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
//                                                         withScrollingVelocity: velocity)
//            return latestOffset
//        }
//        
//        // Page width used for estimating and calculating paging.
//        let pageHeight = cellHeight + self.minimumLineSpacing
//        
//        // Make an estimation of the current page position.
//        let approximatePage = self.collectionView!.contentOffset.y / pageHeight
//        
//        // Determine the current page based on velocity.
//        let currentPage = (velocity.y < 0.0) ? floor(approximatePage) : ceil(approximatePage)
//        
//        // Create custom flickVelocity.
//        let flickVelocity = velocity.y * 0.4
//        
//        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
//        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : round(flickVelocity)
//        
//        // Calculate newVerticalOffset.
//        let newHorizontalOffset = ((currentPage + flickedPages) * pageHeight) - self.collectionView!.contentInset.top
//        
//        return CGPoint(x: proposedContentOffset.x, y: newHorizontalOffset)
//    }
//    
//    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let allAttributes = super.layoutAttributesForElements(in: rect) else {
//            return nil
//        }
//        
//        guard let firstAttribute = allAttributes.first else { return nil }
//        
//        cellHeight = firstAttribute.size.height
//        
//        for attribute in allAttributes {
//            self.updateAttribute(attribute)
//        }
//        
//        return allAttributes
//    }
//    
//    // MARK: - Private Functions
//    
//    private func setup() {
//        scrollDirection = .vertical
//        collectionView!.decelerationRate = UIScrollView.DecelerationRate.normal
//    }
//    
//    private func updateAttribute(_ attributes: UICollectionViewLayoutAttributes) {
//        guard let collectionView = collectionView else { return }
//        let minY = collectionView.bounds.minY + collectionView.contentInset.top
//        let maxY = attributes.frame.origin.y
//        
//        let finalY = max(minY, maxY)
//        var origin = attributes.frame.origin
//        let deltaX = (finalY - origin.y) / attributes.frame.height
//        
//        let scale = 1 - deltaX * scaleRatio
//        let translation = CGFloat((attributes.zIndex + 1) * 10)
//        
//        var t = CGAffineTransform.identity
//        t = t.scaledBy(x: scale, y: 1)
//        
//        if hasStackEffect {
//            t = t.translatedBy(x: 0, y: -(translation + deltaX * translation))
//        }
//        attributes.alpha = 1 - deltaX * 0.1
//        attributes.transform = t
//        
//        origin.y = finalY
//        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
//        attributes.zIndex = attributes.indexPath.row
//    }
//}
