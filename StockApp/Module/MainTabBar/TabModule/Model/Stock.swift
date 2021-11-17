//
//  Stock.swift
//  StockApp
//
//  Created by Nalin Porwal on 16/11/21.
//

import Foundation

// MARK: - StockResponse
struct StockResponse: Codable {
    let success: Bool
    let stockList: [Stock]

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case stockList = "data"
    }
}

// MARK: - Stock
struct Stock: Codable, Hashable {
    let isFav: Bool = false
    let id: String
    let price: Double
    let close: Double
    let change: Double
    let high: Double
    let low: Double
    let volume: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case id = "sid"
        case price = "price"
        case close = "close"
        case change = "change"
        case high = "high"
        case low = "low"
        case volume = "volume"
        case date = "date"
    }
    
}
