//
//  LayerImage.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 11.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct LayerImage: View {
    typealias SheetAction = ((_ item:LayerControllerType) -> Void)
    @EnvironmentObject var vm: DetailViewModel
    private let replaceListener = NotificationCenter.default.publisher(for: Notification.Name("Replace"), object: nil)
    private let manager = RemoveBGWithVision()
    @State private var showingImagePicker = false
    @State private var clearedImage: UIImage?
    let index: Int
    //let model: ProductLayer
    @Binding var selectedIndex: Int
    @State private var inputImage: UIImage?
    var openSheet: SheetAction
    @ObservedObject var model: LayerModel
    let mainWidth: CGFloat
    
    init(index: Int, selectedIndex: Binding<Int>, model:LayerModel, mainWidth:CGFloat, sheetAction: @escaping SheetAction) {
        self.index = index
        self._selectedIndex = selectedIndex
        self.openSheet = sheetAction
        self.model = model
        self.mainWidth = mainWidth
    }
    
    var body: some View {
        content
            .onTapGesture {
                onTab()
            }
            .modifier(DraggableView(isSelected: Binding<Bool>(get: { selectedIndex == index }, set: { _ in })))
            .sheet(isPresented: $showingImagePicker) {
                PhotoPicker(image: $inputImage)
            }
            .onReceive(replaceListener, perform: { _ in
                if selectedIndex == index {
                    showingImagePicker = true
                }
            })
            .onChange(of: inputImage) { oldValue, newValue in
                self.clearedImage = newValue
                /*
                 if selectedIndex == index {
                 manager.processImage(newValue!) { newValue in
                 self.clearedImage = newValue
                 }
                 }*/
            }
    }
}

//MARK: - UI
extension LayerImage {
    
    var content: some View {
        Group {
            if let selected = vm.items[index].selectedImage {
                ZStack {
                    
                    Image(uiImage: selected.stroked3(with: UIColor(vm.items[index].outline.color), thickness: vm.items[index].outline.size))
                        .resizable()
                        .scaledToFit()
                        .shadow(
                            color: vm.items[index].shadow.size > 0 ? vm.items[index].shadow.color : Color.clear,
                            radius: vm.items[index].shadow.size,
                            x:2,y:2
                        )
                }
            }else if let modelColor = vm.items[index].color, !modelColor.isEmpty {
                Color(hex: modelColor)
            }else if let bgImage = vm.items[index].selectedBgImage {
                Image(uiImage: bgImage)
                    .resizable()
                    .scaledToFit()
            }else if let modelColor = vm.items[index].color, !modelColor.isEmpty {
                Color(hex: modelColor)
            }else {
                WebImage(url: URL(string: vm.items[index].link ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: vm.items[index].getWidth(mainWidth),
                           height: vm.items[index].getHeight(mainWidth))
            }
        }
        .overlay(
            Group {
                if selectedIndex == index {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 1)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.clear, lineWidth: 0)
                }
            }
        )
        
    }
}

//MARK: - Logic
extension LayerImage {
    
    func onTab() {
        selectedIndex = index
        openBottomSheet()
    }
    
    func openBottomSheet() {
        switch vm.items[index].type {
        case .bg:
            if let color = vm.items[index].color, !color.isEmpty {
                openSheet(.colorBg)
                
            }else {
                openSheet(.imageBg)
            }
        case .target:
            openSheet(.target)
        case .normal:
            openSheet(.main)
        }
    }
    
}
