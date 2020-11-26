//
//  MarketStateModel.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/26/20.
//

import Foundation

// MARK: - Welcome
struct MarketStateModel: Codable {
    let stats: Stats
    let status: String
}

// MARK: - Stats
struct Stats: Codable {
    let btcRls: BtcRls

    enum CodingKeys: String, CodingKey {
        case btcRls = "btc-usdt"
    }
}

// MARK: - BtcRls
struct BtcRls: Codable {
    let bestSell: String
    let isClosed: Bool
    let dayOpen, dayHigh, bestBuy, volumeSrc: String
    let dayLow, latest, volumeDst, dayChange: String
    let dayClose: String
}
