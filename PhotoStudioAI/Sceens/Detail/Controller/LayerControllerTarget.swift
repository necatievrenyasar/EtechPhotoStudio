//
//  LayerControllerTarget.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 11.04.2024.
//

import SwiftUI

struct LayerControllerTarget: View {
    
    
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @ObservedObject var layer: LayerModel
    
    var openSheet: ((_ item:LayerControllerType) -> Void)?
    
    var body: some View {
        content
            .onChange(of: inputImage) { oldValue, newValue in
                layer.selectedImage = newValue
                layer.type = .normal
                //TODO: - buradaki sorunu bul ve çöz
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    self.openSheet?(.main)
                }
            }.sheet(isPresented: $showingImagePicker) {
                PhotoPicker(image: $inputImage)
            }
    }
}

extension LayerControllerTarget {
    
    var content: some View {
        VStack(spacing:16) {
            LayerHeader(title: "Choose your image") {
                
            }
            
            BigButton(sfName: "photo.on.rectangle.angled", text: "Replace") {
                //TODO: - Clear bg buraya eklenecek
                showingImagePicker = true
            }
            
            Button {
                
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            .frame(height: 40)
        }
        .padding(.bottom, Constants.Padding.sheetBottom)
        .background(
            Color.sheetBg
        )
        .padding(.horizontal, 16)
    }
    
}
