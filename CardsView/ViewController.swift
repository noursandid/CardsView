//
//  ViewController.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardsView: CardsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cardsViews: [BaseCardView] = []
        for _ in 0..<5 {
            cardsViews.append(CardView())
        }
        self.cardsView.backgroundColor = .gray
        self.cardsView.setCards(cards: cardsViews)
        self.cardsView.maximumInterItemSpacing = 50
        self.cardsView.didSelectItem = { index in
            print(index)
        }
    }


}

