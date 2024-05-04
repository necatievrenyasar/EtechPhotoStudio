//
//  MainTabView.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 22.02.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "lasso.and.sparkles")
                        Text("Create")
                    }
                }
                .tag(1)
            
            Text("Your Content")
                .tabItem {
                    VStack {
                        Image(systemName: "internaldrive")
                        
                        Text("Your Content")
                    }
                }
                .tag(2)
            
            Text("Your Content")
                .tabItem {
                    VStack {
                        Image(systemName: "tray.full")
                        Text("Back Mode")
                    }
                }
                .tag(3)
        }
        
    }
}

#Preview {
    MainTabView()
}
