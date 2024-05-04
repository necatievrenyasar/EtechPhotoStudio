//
//  CircleButton.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 1.04.2024.
//

import SwiftUI

struct CircleButton: View {
    
    let imageName: String
    let action: () -> Void
    
    init(sf: String, action: @escaping () -> Void) {
        self.imageName = sf
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .foregroundColor(Color.black)
                .frame(width: 20, height: 20)
                .padding(8)
                .background(Color.white)
                .cornerRadius(22)
                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
        }
    }
}
