//
//  CardView.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

//import UIKit
//
//enum CardType: String {
//    case normalDebit
//    case alsafwa
//    case visaSignature
//    case visaPrepaid
//    case deposit
//    case shabab
//    case almasi
//    case visaPlatinum
//    case tala
//    case senyar
//    case lamar
//    case masterWorld
//}
//
//enum CardCategory: String {
//    case credit = "CREDIT"
//    case prepaid = "PREPAID"
//    case debit = "DEBIT"
//}
//
//enum CardClass: String {
//    case primary = "PRIMARY_CARD"
//    case supplementary = "SUPPLEMENTARY"
//}
//
//
//class CardView: BaseCardView {
//    
//    @IBOutlet weak var supplementaryHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var supplementaryView: UIView!
//    @IBOutlet weak var supplementaryLabel: UILabel!
//    @IBOutlet weak var cardTypeImageView: UIImageView!
//    @IBOutlet weak var cardHolderNameLabel: UILabel!
//    @IBOutlet weak var detailsButton: Button!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var minimumPaymentTitleLabel: UILabel!
//    @IBOutlet weak var availableTitle: UILabel!
//    @IBOutlet weak var currentAmountLabel: UILabel!
//    @IBOutlet weak var minimumPaymentValueLabel: UILabel!
//    @IBOutlet weak var slider: UISlider!
//    @IBOutlet weak var availableAmountLabel: UILabel!
//    @IBOutlet weak var cardNumberLabel: UILabel!
//    @IBOutlet weak var blurrView: UIView!
//    @IBOutlet weak var expireDate: UILabel!
//    weak var delegate: CardViewDelegate?
//    var visaImage = UIImage(named: "visa-white")
//    var card: CardSummary?
//    var primaryCard: CardSummary?
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        commonInit()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//    func commonInit() {
//        fromNib()
//        backgroundColor = .clear
//        titleLabel.font = .regular13
//        cardHolderNameLabel.font = .regular13
//        minimumPaymentTitleLabel.font = .regular13
//        availableTitle.font = .regular15
//        availableTitle.text = L10n.Cards.Label.available
//        minimumPaymentTitleLabel.text = L10n.Cards.Label.cardLimit
//        cardNumberLabel.font = .regular15
//        slider.setThumbImage(UIImage(), for: .normal)
//        slider.tintColor = .positiveGreen
//        supplementaryView.backgroundColor = UIColor.mainBlue
//        supplementaryLabel.font = .regular10
//        supplementaryLabel.text = L10n.Cards.Label.supplementaryCard
//        supplementaryLabel.textColor = .alternativeText
//        supplementaryView.maskCorners(8, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
//        detailsButton.titleLabel?.font = .bold13
//        expireDate.font = .regular13
//        detailsButton.setTitle(L10n.viewDetails, for: .normal)
//    }
//    
//    func handleColors(dark: Bool = false) {
//        let textColor: UIColor = dark ? .black : .white
//        titleLabel.textColor = textColor
//        minimumPaymentTitleLabel.textColor = textColor
//        minimumPaymentValueLabel.textColor = textColor
//        availableTitle.textColor = textColor
//        availableAmountLabel.textColor = textColor
//        currentAmountLabel.textColor = textColor
//        cardNumberLabel.textColor = textColor
//        cardHolderNameLabel.textColor = textColor
//        expireDate.textColor =  textColor
//        detailsButton.setTitleColor(textColor, for: .normal)
//        visaImage = dark ? UIImage(named: "visa-white") : UIImage(named: "visa-black")
//    }
//    
//    func handleCreditCard(card: CardSummary) {
//        handleColors()
//        titleLabel.font = .regular13
//        cardHolderNameLabel.font = .regular13
//        titleLabel.text = L10n.Cards.Label.amountSpent
//        availableAmountLabel.isHidden = false
//        availableTitle.isHidden = false
//        slider.isHidden = false
//        currentAmountLabel.attributedText = NSAttributedString(
//            card.outstandingBalance ?? 0, style: .currency(font: .regular2015), currency: .kwd)
//        availableAmountLabel.attributedText = NSAttributedString(
//            card.availableBalance ?? 0, style: .currency(font: .regular1713), currency: .kwd)
//        
//        slider.minimumValue = 0
//        slider.maximumValue = Float(card.availableBalance ?? 0 + (card.outstandingBalance ?? 0))
//        slider.value = Float(card.outstandingBalance ?? 0)
//            minimumPaymentTitleLabel.text = L10n.Cards.Label.cardLimit
//            minimumPaymentValueLabel.attributedText = NSAttributedString(
//                card.cardLimit ?? 0, style: .currency(font: .regular2015), currency: .kwd)
//        if card.cardClass == CardClass.supplementary.rawValue {
//            supplementaryHeaderView(hidden: false)
//        } else {
//            
//            supplementaryHeaderView(hidden: true)
//        }
//    }
//    
//    func supplementaryHeaderView(hidden: Bool) {
//        self.supplementaryHeightConstraint.constant = hidden ? 0 : 17
//        self.supplementaryView.isHidden = hidden
//        layoutIfNeeded()
//    }
//    
//    func handlePrepaidCard(card: CardSummary) {
//        supplementaryHeaderView(hidden: true)
//        handleColors(dark: true)
//        titleLabel.font = .regular13
//        cardHolderNameLabel.font = .regular13
//        titleLabel.text = L10n.Cards.Label.availableAmount
//        availableAmountLabel.isHidden = true
//        availableTitle.isHidden = true
//        minimumPaymentValueLabel.isHidden = true
//        minimumPaymentTitleLabel.isHidden = true
//        slider.isHidden = true
//        detailsButton.isHidden = true
//        if !(card.active ?? false) {
//            titleLabel.text = LanguageManager.shared.isRTL ?
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.arabicDescription :
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.englishDescription
//            currentAmountLabel.attributedText =
//                NSAttributedString(string: card.cardHolderName ?? "",
//                                   attributes: [NSAttributedString.Key.font: UIFont.regular20])
//        } else {
//            cardHolderNameLabel.text = LanguageManager.shared.isRTL ?
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.arabicDescription :
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.englishDescription
//            currentAmountLabel.text = nil
//            currentAmountLabel.attributedText = NSAttributedString(
//                card.availableBalance ?? 0, style: .currency(font: .regular2417), currency: .kwd)
//        }
//    }
//    
//    func handleImage(card: CardSummary) {
//        switch card.cardLogoInfo?.cardLogo {
//        case "400":
//            imageView.image = UIImage(named: "prepaid.png")
//        case "300", "320":
//            imageView.image = UIImage(named: "platinum.png")
//        case "500", "520":
//            imageView.image = UIImage(named: "VISASignature.png")
//            cardNumberLabel.textColor = .lightGray
//        case "700", "720":
//            imageView.image = UIImage(named: "masterWorld")
//            cardNumberLabel.textColor = .lightGray
//        case "800", "820":
//            imageView.image = UIImage(named: "alMasiWorldEliteCreditCard")
//        case "900", "920":
//            imageView.image = UIImage(named: "platinumCreditCard")
//        default:
//            imageView.image = UIImage(named: "cardPlaceholder")
//        }
//        
//        if card.cardLogoInfo?.cardLogo == "700" ||  card.cardLogoInfo?.cardLogo ==  "720"
//            || card.cardLogoInfo?.cardLogo ==  "900" ||  card.cardLogoInfo?.cardLogo ==  "920" {
//            cardTypeImageView.image = UIImage(named: "mastercard")
//        } else if card.cardLogoInfo?.cardLogo == "800" || card.cardLogoInfo?.cardLogo == "820"{
//            cardTypeImageView.image = UIImage(named: "mastercard_silver")
//        } else {
//            cardTypeImageView.image = visaImage
//        }
//    }
//    
//    func configureCard(_ card: CardSummary, primaryCard: CardSummary?) {
//        self.card = card
//        self.primaryCard = primaryCard
//        handleImage(card: card)
//        cardHolderNameLabel.font = .regular13
//        if card.cardClass == CardClass.supplementary.rawValue {
//            cardHolderNameLabel.text = card.cardHolderName
//        } else {
//            cardHolderNameLabel.text =  LanguageManager.shared.isRTL ?
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.arabicDescription :
//                CardsInfoName(rawValue: (card.cardLogoInfo?.cardLogo)! )?.englishDescription
//        }
//      
//        cardNumberLabel.attributedText = NSAttributedString.cardNumber(number: card.cardNumber)
//        
//        if card.active ?? false {
//            blurrView.alpha = 0
//            detailsButton.isHidden = false
//        } else {
//            blurrView.alpha = 0.5
//            detailsButton.isHidden = true
//        }
//        
//        if card.cardInfo.type == CardCategory.prepaid.rawValue {
//                   handlePrepaidCard(card: card)
//               } else {
//                   handleCreditCard(card: card)
//               }
//        
//        expireDate.text = L10n.Cards.Label.expiresOn(card.expiryDate ?? "")
//    }
//    
//    func changeSupplementaryCardLimit(cardLimit: Decimal?) {
//        minimumPaymentValueLabel.attributedText = NSAttributedString(
//            cardLimit ?? 0, style: .currency(font: .regular2015), currency: .kwd)
//    }
//    
//    override func didBecomeInactive() {
//        super.didBecomeInactive()
//        self.detailsButton.isEnabled = false
//    }
//    
//    override func didBecomActive() {
//        super.didBecomActive()
//        self.detailsButton.isEnabled = true
//    }
//    
//    @IBAction func didPressDetailsButton(_ sender: Any) {
//        guard let card = card else {
//            return
//        }
//        self.delegate?.didSelectCard(card: card, primaryCardLimit: self.primaryCard?.cardLimit)
//    }
//}
