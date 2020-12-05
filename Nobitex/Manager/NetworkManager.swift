//
//  NetworkManager.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let marketState = MarketStateModel.shared
    private let baseURL: String = "https://api.nobitex.ir"
    
    func getAuthToken(username: String, password: String, remember: String, otp: String) {
        let url = String(format: baseURL + "/auth/login/")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDictionary = ["username" : username, "password" : password, "remember" : remember]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(otp, forHTTPHeaderField: "X-TOTP")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getMarketInfo(symbol: String) {
        let url = String(format: baseURL + "/v2/orderbook")
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDictionary = ["symbol" : symbol]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getMarketStats(srcCurrency: String, dstCurrency: String, completion: @escaping (Bool) -> ()) {
        let url = String(format: baseURL + "/market/stats")
        guard let serviceUrl = URL(string: url) else { return }
        let parameters = ["srcCurrency" : srcCurrency, "dstCurrency" : dstCurrency]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    
                    let stats = json["stats"] as! [String:Any]
                    let symbol = stats["\(srcCurrency)-\(dstCurrency)"] as! [String:Any]
                    let latestPrice = symbol["latest"] as! String
                    let dayChange = symbol["dayChange"] as! String
                    let formatedSymbol = String("\(srcCurrency)").uppercased()
                    let formatedLastPrice = String(latestPrice.prefix(8))
                    
                    if !self.marketState.symbol.contains(formatedSymbol) {
                        self.marketState.symbol.append(formatedSymbol)
                        self.marketState.latestPrice.append(formatedLastPrice)
                        self.marketState.dayChange.append(dayChange)
                    }
                    
                    completion(true)
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getTrades(symbol: String, completion: @escaping (Bool, TradesModel) -> ()) {
        let url = String(format: baseURL + "/v2/trades")
        guard let serviceUrl = URL(string: url) else { return }
        let parameters = ["symbol" : symbol]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let model: TradesModel!
                    model = try JSONDecoder().decode(TradesModel.self, from: data)
                    completion(true, model)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
