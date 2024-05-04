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
            //ContentView2()
            //Fake2()
            //ContentView2()
            //ContentView2()
            //Fake()
            //ContentView1()
        }
    }
}


struct Fake2: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "pngegg")!.stroked(thickness: 10) )
        }.background(Color.yellow)
    }
}
