//
//  ColorBGController.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 9.04.2024.
//

import SwiftUI

struct LayerControllerColorfull: View {
    
    var colors: [Color] = [.red, .yellow, .blue, .orange]
    @State private var colorValue = Color.orange
    @ObservedObject var layer: LayerModel
    
    
    var body: some View {
        content
            .onChange(of: colorValue) { oldValue, newValue in
                layer.color = newValue.toHexString()
            }
        }
}

extension LayerControllerColorfull {
    var content: some View {
        VStack {
            LayerHeader(title: "Choose your color") {
                
            }
            colorList
        }
        .padding(.bottom, Constants.Padding.sheetBottom)
        .background(
            Color.sheetBg
        )
    }
    
    
    var colorList: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(colors, id: \.self) { item in
                    Rectangle()
                        .fill(item)
                        .frame(width: 40, height:40)
                        .cornerRadius(25)
                        .shadow(radius: 2)
                        .onTapGesture {
                            layer.color = item.toHexString()
                        }
                }
                ColorPicker("", selection: $colorValue)
                    .labelsHidden()
                    .frame(width: 40, height: 40)
            }
        }
        .frame(height: 60)
    }
    
}
