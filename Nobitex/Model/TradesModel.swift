//
//  TradesModel.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/27/20.
//

import Foundation

// MARK: - TradesModel
struct TradesModel: Codable {
    let status: String
    let trades: [Trade]
}

// MARK: - Trade
struct Trade: Codable {
    let time: Int
    let price, volume, type: String
}
