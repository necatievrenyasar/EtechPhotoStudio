//
//  PaywallPlanRow.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 17.05.2024.
//

import Foundation
import SwiftUI

struct PaywallPlanRowModel {
    var isSelected = false
    var title: String
    var subTitle: String
    var rightText: String
    
    init(title: String, subTitle: String = "", rightText: String = "") {
        self.title = title
        self.subTitle = subTitle
        self.rightText = rightText
    }
    
    
    mutating func setSelected(_ state: Bool) {
        isSelected = state
    }
}

struct PaywallPlanRow: View {
    
    var model: PaywallPlanRowModel
    
    var body: some View {
        HStack(spacing:0) {
            Circle()
                .stroke(model.isSelected ? Color.purple1 : .gray, lineWidth: 2)
                .fill(model.isSelected ? Color.purple1 : .clear)
                .frame(width: 20, height: 20)
                
            VStack(alignment: .leading, spacing: 0) {
                
                Text(model.title)
                    .foregroundColor(model.isSelected ? Color.black : Color.lightgray1)
                    .font(.system(size: 18, weight: model.isSelected ? .semibold : .regular, design: .rounded))
                if !model.subTitle.isEmpty {
                    Text("$20/month")
                        .font(.system(size: 14))
                        .foregroundColor(model.isSelected ? Color.black : Color.lightgray1)
                }
            }.padding(.leading, 16)
            Spacer()
        }
        .frame(height: 64)
        .padding(.horizontal, 16)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.purple1, lineWidth: model.isSelected ? 2 : 0)
            )
        .background(
            Color.white.cornerRadius(16)
        )
    }
}


#Preview {
    
    var model1 = PaywallPlanRowModel(title: "VIP Yearly:529,99",
                                     subTitle: "44,17/month")
    model1.setSelected(false)
    
    var model2 = PaywallPlanRowModel(title: "VIP Forever: 799,99",
                                     subTitle: "Limited-time")
    model2.setSelected(true)
    
    return ZStack {
        VStack {
            PaywallPlanRow(model: model1)
            PaywallPlanRow(model: model2)
            Spacer()
        }.padding()
    }.background(Color.gray1)
}
