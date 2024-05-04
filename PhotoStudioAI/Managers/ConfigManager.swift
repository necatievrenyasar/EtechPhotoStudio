//
//  ConfigManager.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 18.03.2024.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class ConfigManager {
    
    func fetchConfig() async throws -> ConfigResponse {
        do {
            let db = Firestore.firestore()
            
            let document = db.collection("settings").document("general")
            let snapshot = try await document.getDocument()
            
            if snapshot.exists, let data = snapshot.data() {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let response = try JSONDecoder().decode(ConfigResponse.self, from: jsonData)
                return response
            }else {
                throw StalkerError.firebaseNoData
            }
        }catch {
            throw error
        }
    }
    
}

struct ConfigResponse: Codable {
    var apiUrl: String
    var maintenanceMode: Bool
    var updateAppVersion: UpdateAppResponse
    
    enum CodingKeys: String, CodingKey {
        case apiUrl = "api_url"
        case maintenanceMode = "maintenance_mode"
        case updateAppVersion = "update_app_version"
    }
}

struct UpdateAppResponse: Codable {
    var hardMessage: String
    var hardVersion: String
    
    enum CodingKeys: String, CodingKey {
        case hardMessage = "hard_message"
        case hardVersion = "hard_version"
    }
    //TODO: - CheckVersion
    func isLowerThenHardVersion() -> Bool {
        return false
    }
}


enum StalkerError: Error {
    case firebaseNoData
}
