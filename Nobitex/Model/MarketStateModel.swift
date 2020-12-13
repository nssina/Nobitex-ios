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
    var symbolName: [String] = []
    var latestPrice = [String]()
    var dayChange = [String]()
}
