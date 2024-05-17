//
//  PaywallVM.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 17.05.2024.
//

import Foundation

import Foundation
import Combine

final class PaywallVM: ObservableObject {
    
    @Published var rows: [PaywallPlanRowModel] = []
    
    
    init() {
        var model1 = PaywallPlanRowModel(title: "VIP Yearly:529,99", subTitle: "44,17/month")
        var model2 = PaywallPlanRowModel(title: "VIP Forever: 799,99", subTitle: "Limited-time")
        model2.setSelected(true)
        
        rows = [model1, model2]
    }
    
    
    func getProducts() {
        
    }
    
    
}
