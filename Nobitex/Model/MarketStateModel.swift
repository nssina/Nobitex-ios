//
//  MarketStateModel.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/26/20.
//

import Foundation

class MarketStateModel {
    
    static let shared = MarketStateModel()
    
    var symbol = [String]()
    var latestPrice = [String]()
    var dayChange = [String]()
    
    let symbolNames: [String:String] = [
        "BTC" : "Bitcoin",
        "ETH" : "Ethereum",
        "LTC" : "Litecoin",
        "XRP" : "XRP",
        "BNB" : "Binance Coin",
        "BCH" : "Bitcoin Cash",
        "EOS" : "EOS",
        "TRX" : "TRON",
        "XLM" : "Stellar",
        "DOGE" : "Dogecoin"
    ]
}
