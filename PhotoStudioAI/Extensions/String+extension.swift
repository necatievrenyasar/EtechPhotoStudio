//
//  String+extension.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 30.04.2024.
//

import Foundation
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
