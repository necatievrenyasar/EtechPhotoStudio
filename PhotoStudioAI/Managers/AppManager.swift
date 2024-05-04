//
//  AppManager.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 22.02.2024.
//

import Combine
final class AppManager: ObservableObject {
    @Published var routing = Routing.tabbar
}

enum Routing {
    case tabbar
    case splash
    case login
}
