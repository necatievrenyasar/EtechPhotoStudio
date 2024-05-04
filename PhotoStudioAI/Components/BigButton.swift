//
//  BigButton.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 1.04.2024.
//

import SwiftUI

struct BigButton: View {
    
    let sfName: String
    let text: String
    let action: () -> Void
    
    init(sfName: String, text: String, action: @escaping () -> Void) {
        self.sfName = sfName
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: sfName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                    Text(text)
                        .fontDesign(.rounded)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 8)
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(16)
        }
    }
}
