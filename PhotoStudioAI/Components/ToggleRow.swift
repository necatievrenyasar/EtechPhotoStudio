//
//  ToggleRow.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 1.04.2024.
//

import SwiftUI

struct ToggleRow: View {
    
    @Binding var isOn: Bool
    let title: String
    
    var body: some View {
        Toggle(isOn: $isOn, label: {
            Text(title)
                .fontDesign(.rounded)
                .foregroundColor(.black)
            
        })
        .frame(height: 50)
        .padding(.horizontal, 16)
        .background(
            Color.white
        )
        .cornerRadius(16)
    }
}
