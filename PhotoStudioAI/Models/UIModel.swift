//
//  UIModel.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 21.04.2024.
//

import Foundation
import Combine
import SwiftUI

class LayerModel: ObservableObject {
    //Type
    @Published var type: ProductType = .normal
    
    //Image
    @Published var selectedBgImage: UIImage? = nil 
    @Published var selectedImage: UIImage? = nil
    @Published var link: String? = nil
    @Published var color: String?
    
    //Design
    @Published var outline: OutlineModel = OutlineModel()
    @Published var shadow: ShadowModel = ShadowModel()
    var width: CGFloat = 1080
    var height: CGFloat = 1080
    
    func resetOutline() {
        outline.size = 0
    }
    
    func getWidth(_ main: CGFloat) -> CGFloat {
        let screenScale = (UIScreen.main.bounds.width - 48) / main
        return screenScale * width
    }
    
    func getHeight(_ main: CGFloat) -> CGFloat {
        let screenScale = (UIScreen.main.bounds.width - 48) / main
        return screenScale * height
    }
    
}

extension LayerModel {
    
    static func create(product model: ProductLayer) -> LayerModel {
        let m = LayerModel()
        m.type = model.type
        m.link = model.link
        m.color = model.color
        
        if let size = model.size, !size.isEmpty {
            let ar = size.components(separatedBy: "x")
            if ar.count == 2 {
                m.width = CGFloat( Int( ar[0] ) ?? 1080 )
                m.height = CGFloat( Int( ar[1] ) ?? 1080 )
            }
        }
        return m
    }
    
}




class OutlineModel: ObservableObject {
    @Published var color: Color = .white
    @Published var size: CGFloat = 1
}

class ShadowModel: ObservableObject {
    @Published var color: Color = .black
    @Published var size: CGFloat = 1
}

