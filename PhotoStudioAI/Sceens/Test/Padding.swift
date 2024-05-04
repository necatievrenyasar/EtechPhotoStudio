//
//  Padding.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 1.05.2024.
//

import SwiftUI

struct Padding: View {
    var body: some View {
        ZStack {
        
            Color.red.frame(width: 100,height: 100)
            Color.yellow.frame(width: 50,height: 50).offset(x:25)
            
        }
        
    }
}

#Preview {
    Padding()
}
