//
//  PaymentManager.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 15.05.2024.
//

import Foundation
import RevenueCat
import Combine
import StoreKit

class PayManager: NSObject {
    static let shared = PayManager()
    private var subscribedCancellable: AnyCancellable?
    private let offerName: String = "basic_offerings"
}


//MARK: - RevenueCat
extension PayManager: PurchasesDelegate {
    
    func setupRevenueCat() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Constants.ApiKey.revenueCat)
        Purchases.shared.delegate = self
    }
    
}

extension PayManager {
    
    func syncSubscriptionStatus() {
        assert(Purchases.isConfigured, "You must configure RevenueCat before calling this method.")
        Task {
            for await customerInfo in Purchases.shared.customerInfoStream {
                let hasActiveSubscription = !customerInfo.entitlements.active.isEmpty
                if hasActiveSubscription {
                    setUserPaid(true)
                } else {
                    setUserPaid(false)
                }
            }
        }
    }
    
    
    func setUserPaid(_ status: Bool) {
       // Storage.set(Storage.IsPaid, value: status)
    }
    
    var isUserPaid: Bool {
        //Storage.getBool(Storage.IsPaid)
        return false
    }
    
    func reloadStatus() {
        Purchases.shared.getCustomerInfo { [weak self] (customerInfo, error) in
            guard let self else { return }
            if let error  {
                //AppAnalytics.paymentStatus("Payment_Status_Error")
                return
            }
            guard let customer = customerInfo else {
                //AppAnalytics.paymentStatus("Payment_Status_Customer_nil")
                return
            }
            if !customer.entitlements.active.isEmpty {
                setUserPaid(true)
            }else {
                setUserPaid(false)
            }
        }
    }
    
    
    func getProductList() {
        Purchases.shared.getOfferings { [weak self] (offerings, error) in
            guard let self else {return}
            if let error  {
                print("Error \(error)")
                return
            }
            let packages = offerings?.offering(identifier: offerName)?.availablePackages
           print("***** Packages \(packages)")
        }
    }
}
