//
//  PhotoStudioAIApp.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 22.02.2024.
//

import SwiftUI

@main
struct PhotoStudioAIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let productManager = ProductManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    InAppPurchaseManager.config()
                }
            //ContentView2()
            //Fake2()
            //ContentView2()
            //ContentView2()
            //Fake()
            //ContentView1()
        }
    }
}
