//
//  MainImageController.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 1.04.2024.
//

import SwiftUI

struct LayerControllerMain: View {
    
    enum BtnType {
        case replace
        case delete
    }
    
    @ObservedObject var layer: LayerModel
    
    var action:(BtnType) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                BigButton(sfName: "photo.on.rectangle.angled", text: "Replace") {
                    action(.replace)
                }
                
                BigButton(sfName: "trash.fill", text: "Delete") {
                    action(.delete)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            
            
            VStack(spacing:16) {
                OutlineToggle(layer: layer)
                ShadowToggle(layer: layer)
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            //Text("\(layer.shadow.size)")
            Color.white.opacity(0.0001).frame(height: 20)
            
        }
        .padding(.bottom, Constants.Padding.sheetBottom)
        .background(
            Color(.sheetBg)
        )
    }
}
