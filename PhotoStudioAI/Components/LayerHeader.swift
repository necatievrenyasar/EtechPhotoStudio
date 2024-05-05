//
//  LayerHeader.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 11.04.2024.
//

import SwiftUI

struct LayerHeader: View {
    
    let title: String
    
    var closeAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
            
            Spacer()
            
            Button {
                closeAction()
            } label: {
                Text("Done")
            }
        }
        .padding(.bottom, 16)
        
    }
}
