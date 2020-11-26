//
//  MarketsViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import UIKit

class MarketsViewController: UIViewController {
    
    private let network = NetworkManager.shared
    private let marketState = MarketStateModel.shared
    
    private lazy var marketsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MarketsCell.self, forCellReuseIdentifier: "marketsCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(marketsTableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setMarketsTableViewConstraints()
        
        sendCoinsRequests()
    }
}

extension MarketsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketState.symbol.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketsCell", for: indexPath) as! MarketsCell
        
        if marketState.symbol.count > 0 {
            if marketState.dayChange[indexPath.row].contains("-") {
                cell.dayChangeView.backgroundColor = .systemRed
            } else {
                cell.backgroundColor = .systemGreen
            }
            cell.dayChangePercent.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.dayChangePercent.text = marketState.dayChange[indexPath.row]
            cell.symbol.text = marketState.symbol[indexPath.row]
            cell.latestPriceLabel.text = marketState.latestPrice[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension MarketsViewController {
    
    func sendCoinsRequests() {
        network.getMarketStats(srcCurrency: "btc", dstCurrency: "usdt") { (success) in
            if success {
                self.network.getMarketStats(srcCurrency: "eth", dstCurrency: "usdt") { (success) in
                    if success {
                        self.network.getMarketStats(srcCurrency: "ltc", dstCurrency: "usdt") { (success) in
                            if success {
                                self.network.getMarketStats(srcCurrency: "xrp", dstCurrency: "usdt") { (success) in
                                    if success {
                                        self.network.getMarketStats(srcCurrency: "bnb", dstCurrency: "usdt") { (success) in
                                            if success {
                                                DispatchQueue.main.async {
                                                    self.marketsTableView.reloadData()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setMarketsTableViewConstraints() {
        NSLayoutConstraint.activate([
            marketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            marketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            marketsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            marketsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
