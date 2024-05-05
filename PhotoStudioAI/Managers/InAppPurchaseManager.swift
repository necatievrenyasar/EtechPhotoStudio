//
//  InAppPurchase.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 5.05.2024.
//

import Foundation
import RevenueCat
final class InAppPurchaseManager {
    
    static func config() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_niNYXeARXFtpscSXqGsSxnbYkYx", appUserID: "")
    }
    
}
