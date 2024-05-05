//
//  LayerControllerChangeBGImage.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 14.04.2024.
//

import SwiftUI

struct LayerControllerChangeBGImage: View {
    
    @ObservedObject var layer: LayerModel
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        content
            .onChange(of: inputImage) { oldValue, newValue in
                layer.selectedBgImage = newValue
            }.sheet(isPresented: $showingImagePicker) {
                PhotoPicker(image: $inputImage)
            }
    }
}


extension LayerControllerChangeBGImage {
    
    var content: some View {
        VStack(spacing:0) {
            LayerHeader(title: "Choose your background image") {
                
            }
            HStack(spacing: 16) {
                BigButton(sfName: "square.3.layers.3d.top.filled", text: "AI backgrounds") {
                }
                
                BigButton(sfName: "photo.stack", text: "Your Libraries") {
                    showingImagePicker = true
                }
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, Constants.Padding.horizontal)
        .padding(.bottom, Constants.Padding.sheetBottom)
        .background(
            Color.sheetBg
        )
    }
}

