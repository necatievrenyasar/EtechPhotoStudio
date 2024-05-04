//
//  DraggableView.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 28.03.2024.
//

import Foundation
import SwiftUI

struct DraggableView: ViewModifier {
    
    @GestureState private var dragOffset: CGSize = .zero
    @GestureState private var rotationAngle: Angle = .zero
    @State private var accumulatedRotationAngle: Angle = .zero
    @State private var positionOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    var isSelected: Binding<Bool>
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .rotationEffect(accumulatedRotationAngle + rotationAngle)
            .offset(x: positionOffset.width + dragOffset.width, y: positionOffset.height + dragOffset.height)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        if !isSelected.wrappedValue {return}
                        scale = value
                    }
            )
            .simultaneousGesture(
                RotationGesture()
                    .updating($rotationAngle) { latestAngle, state, _ in
                        if !isSelected.wrappedValue {return}
                        state = latestAngle
                    }
                    .onEnded { angle in
                        if !isSelected.wrappedValue {return}
                        accumulatedRotationAngle += angle
                    }
            )
            .simultaneousGesture(
                DragGesture()
                    .updating($dragOffset) { latestDrag, state, _ in
                        if !isSelected.wrappedValue {return}
                        state = latestDrag.translation
                    }
                    .onEnded { value in
                        if !isSelected.wrappedValue {return}
                        positionOffset = CGSize(width: positionOffset.width + value.translation.width, height: positionOffset.height + value.translation.height)
                    }
            )
    }
}

