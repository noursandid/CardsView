//
//  CurrencyName.swift
//  CardsView
//
//  Created by Nour Sandid on 7/11/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import Foundation

//enum CardsInfoName: String {
//    case v220 = "220"
//    case v200 = "200"
//    case v400 = "400"
//    case v520 = "520"
//    case v320 = "320"
//    case v300 = "300"
//    case v120 = "120"
//    case v100 = "100"
//    case v500 = "500"
//    case v700 = "700"
//    case v800 = "800"
//    case v820 = "820"
//    case v720 = "720"
//    case v920 = "920"
//    case v900 = "900"
//    
//    var localizedDescription: String {
//        if LanguageManager.shared.isRTL {
//            return arabicDescription ?? ""
//        }
//        return englishDescription ?? ""
//    }
//    
//    var englishDescription: String? {
//        if let list = getCurrencyNamesList() {
//            return list[rawValue]?["englishDescription"] as? String ?? ""
//        }
//        return ""
//    }
//    
//    var arabicDescription: String? {
//        if let list = getCurrencyNamesList() {
//            return list[rawValue]?["arabicDescription"] as? String ?? ""
//        }
//        return ""
//    }
//    
//    private func getPlist() -> [String: Any]? {
//        if  let path = Bundle.main.path(forResource: "Cards", ofType: "plist"),
//            let xmlProperty = FileManager.default.contents(atPath: path) {
//            return (try? PropertyListSerialization.propertyList(from: xmlProperty,
//                                                                options: .mutableContainersAndLeaves,
//                                                                format: nil)) as? [String: Any]
//        }
//        return nil
//    }
//    
//    private func getCurrencyNamesList() -> [String: [String: Any]]? {
//        if let plist = getPlist(), let section = plist["Cards"] as? [String: [String: Any]] {
//            return section
//        }
//        return nil
//    }
//    
//}
