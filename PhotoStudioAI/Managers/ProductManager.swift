//
//  ProductManager.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 18.03.2024.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import SDWebImage

final class ProductManager {
    
    func fetchConfig() async throws -> [ProductListModel] {
        do {
            let db = Firestore.firestore()
            let documents = try await db.collection("products").getDocuments()
            var listData = [ProductListModel]()
            
            try documents.documents.forEach { doc in
                if doc.exists {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let response = try JSONDecoder().decode(ProductListModel.self, from: jsonData)
                    listData.append(response)
                }
            }
            
            return listData
        }catch {
            throw error
        }
    }
    
}


struct ProductListModel: Codable {
    let id: String = UUID().uuidString
    let title: String
    let order: Int
    var product: [ProductModel]?
    
    
    func getItems() -> [ProductModel] {
        return product ?? []
    }
}

struct ProductModel: Codable, Identifiable {
    
    let id: String = UUID().uuidString
    var img: String?
    var pro: Bool?
    var layer: [ProductLayer]?
    
    func image() -> String {
        return Constants.Server.imageUrl + (img ?? "")
    }
    
    func getLayerProduct() -> [ProductLayer] {
        return layer ?? []
    }
    
    func getBGWidth() -> CGFloat {
        if let bg = getLayerProduct().first(where: { $0.type == .bg }), let bgSize = bg.size, !bgSize.isEmpty {
            let ar = bgSize.components(separatedBy: "x")
            if ar.count == 2 {
                let w = Int(ar[0])
                return CGFloat(w ?? 100)
            }
        }
        return 1080
    }
    
}

enum ProductType: Codable {
    case bg
    case target
    case normal
}

struct ProductLayer: Codable, Identifiable{
    let id: String = UUID().uuidString
    var type: ProductType
    var link: String?
    var color: String?
    var selectedBgImage: UIImage? = nil
    var selectedImage: UIImage? = nil
    var outline: OutlineModel = OutlineModel()
    var size: String?
    
    enum CodingKeys: String, CodingKey {
        case link, type, color, size
    }
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .type) {
            switch value {
            case "bg":
                type = .bg
            case "target":
                type = .target
            default:
                type = .normal
            }
        }else {
            type = .normal
        }
        
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .link) {
            self.link = Constants.Server.imageUrl + value
        }else {
            self.link = nil
        }
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .size) {
            self.size = value
        }else {
            self.size = nil
        }
        
        self.color = try? values.decodeIfPresent(String.self, forKey: .color) ??  nil
        
    }
    
    init(type: ProductType = .normal, link:String? = nil, color: String? = nil){
        self.type = type
        self.link = link
        self.color = color
    }
    
    
    mutating func updateImage(_ img: UIImage) {
        self.selectedBgImage = img
    }
    
    mutating func download() {
        var result =  self
        SDWebImageManager.shared.loadImage(with: URL(string: link ?? ""), progress: .none) { img, _, _, _, _, _ in
            
            if let img {
                result.updateImage(img)
            }
        }
        self = result
    }
    
    
    
}


