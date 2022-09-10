//
//  CardView.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

class CardView: BaseCardView {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        addSubview(imageView)
        imageView.image = UIImage(named: "card")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
    }
    override func didBecomeInactive() {
        imageView.alpha = 0.5
    }
    override func didBecomActive() {
        imageView.alpha = 1
    }
}
