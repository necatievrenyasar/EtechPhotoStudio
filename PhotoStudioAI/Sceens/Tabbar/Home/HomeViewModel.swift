//
//  HomeViewModel.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 22.02.2024.
//

import Foundation
final class HomeViewModel: ObservableObject {
    @Published var sections: [ProductListModel] = []
    var manager = ProductManager()
}

extension HomeViewModel {
    
    @MainActor
    func fetchData() async {
        do {
            let data = try await manager.fetchConfig()
            sections = data
        }catch {
            print("ERRORRRR \(error.localizedDescription)")
        }
    }
    
}








