//
//  RealGame.swift
//  depot-vente-frontend-mobile
//
//  Created by etud on 19/03/2025.
//

import Foundation

struct RealGame: Identifiable, Codable {
    let id: Int
    let unit_price: Int
    let gameName: String
    let gameEditor: String
    let qty: Int
}
