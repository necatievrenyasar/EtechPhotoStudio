//
//  ShadowToggle.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 29.04.2024.
//

import SwiftUI

struct ShadowToggle: View {
    @ObservedObject var layer: LayerModel
    @State var isOn: Bool = false
    @State var showDetail = false
    @State var isFirstOpen = true
    let title: String = "Shadow"
    
    init(layer: LayerModel) {
        self.layer = layer
    }
    
    var body: some View {
        content
            .onChange(of: isOn) { _, _ in
                if isOn == false {
                    $layer.shadow.size.wrappedValue = 0
                }
                withAnimation {
                    showDetail = isOn
                }
            }
            .onChange(of: showDetail) { oldValue, newValue in
                if newValue == true && isFirstOpen {
                    isOn = true
                }
                isFirstOpen = false
            }
    }
}

extension ShadowToggle {
    
    var content: some View {
        
        VStack {
            HStack {
                Toggle(isOn: $isOn, label: {
                    Text(title)
                        .fontDesign(.rounded)
                        .foregroundColor(.black)
                    
                })
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(showDetail ? 90 : 0))
            }
            .background(Color.white.onTapGesture {
                withAnimation {
                    self.showDetail.toggle()
                }
            })
            .frame(height: 50)
            
            if showDetail {
                VStack {
                    HStack {
                        Slider(value: $layer.shadow.size, in: 0...30)
                        ColorPicker("", selection: $layer.shadow.color)
                            .labelsHidden()
                    }.padding(.bottom, 16)
                }
            }
            
        }
        .padding(.horizontal, 16)
        .background(
            Color.white.cornerRadius(16)
        )
    }
    
}

#Preview {
    
    @ObservedObject var vm = LayerModel()
    
    return ZStack {
        Color.gray1
        ShadowToggle(layer: vm)
    }
    
}

