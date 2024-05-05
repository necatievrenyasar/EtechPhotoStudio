//
//  DetailView.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 19.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import BottomSheet

enum LayerControllerType {
    case colorBg
    case imageBg
    case target
    case main
    case none
}

class DetailViewModel: ObservableObject {
    @Published var items: [LayerModel] = []
}

struct DetailView: View {
    @StateObject var vm = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedIndex = 0
    @State private var offset = CGSize.zero
    @State private var showingImagePicker = false
    @State private var shadow: Bool = false
    @State private var outline: Bool = false
    @State private var layerController: LayerControllerType = .none
    @State private var layerControllerId = UUID().uuidString
    @State private var bottomSheetPosition = BottomSheetPosition.dynamic
    private let imagePedding: CGFloat = 24
    let model: ProductModel
    @State var isDraw = false
    let mainWidth: CGFloat
    
    init(model: ProductModel) {
        self.model = model
        self.mainWidth = model.getBGWidth()
    }
    
    var body: some View {
        content
            .onAppear {
                vm.items = model.getLayerProduct().map{ LayerModel.create(product: $0) }
                isDraw = true
            }
    }
}

extension DetailView {
    
    var content: some View {
        ZStack {
            Color(.white1).edgesIgnoringSafeArea(.all)
            //Color(hex: selectedProductLayer.color ?? "aaaaaa").frame(height: 40)
            VStack {
                
                topController
                    .padding(.top, 24)
                
                ZStack {
                    Image("transparentbg")
                        .resizable()
                        .scaledToFill()
                    
                    imageContainer()
                }
                .frame(width: UIScreen.main.bounds.width - (imagePedding * 2),
                       height: UIScreen.main.bounds.width - (imagePedding * 2))
                .clipped()
                .padding(.top, 24)
                .shadow(radius: 6)
                Spacer()
                layerControllers()
            }
        }
    }
    
    var topController: some View {
        HStack {
            CircleButton(sf: "xmark") {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
            CircleButton(sf: "square.and.arrow.up") {
                
            }
        }.padding(.horizontal, 16)
    }
    
    
    @ViewBuilder
    func imageContainer() -> some View {
        ZStack {
            ForEach(0..<vm.items.count, id: \.self) { index in
                LayerImage(index: index,
                           selectedIndex: $selectedIndex,
                           model: vm.items[index],
                           mainWidth: mainWidth,
                           sheetAction: openSheetWithSelectedType(_:))
                .environmentObject(vm)
            }
        }
    }
    
    
    func openSheetWithSelectedType(_ type: LayerControllerType) {
        withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.layerController = type
            }
            
        }
    }
    
}


extension DetailView {
    
    @ViewBuilder
    func layerControllers() -> some View {
        Color.yellow.frame(height: 1)
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                         switchablePositions: [BottomSheetPosition.dynamic]) {
                switch layerController {
                case .main:
                    mainLayer
                case .colorBg:
                    colorfullLayer
                case .imageBg:
                    imageBackgroundLayer
                case .target:
                    targetLayer
                default:
                    Color.red.frame(height: 2)
                }
            }
    }
    
    
    var mainLayer: some View {
        LayerControllerMain(layer: vm.items[selectedIndex]) { btnType in
            switch btnType {
            case .replace:
                NotificationCenter.default.post(name: Notification.Name("Replace"), object: nil)
            case .delete:
                ()
            }
        }
    }
    
    
    
    var targetLayer: some View {
        LayerControllerTarget(layer: vm.items[selectedIndex], openSheet: openSheetWithSelectedType(_:))
    }
    
    var colorfullLayer: some View {
        LayerControllerColorfull(layer: vm.items[selectedIndex])
    }
    
    var imageBackgroundLayer: some View {
        LayerControllerChangeBGImage(layer: vm.items[selectedIndex])
    }
}
