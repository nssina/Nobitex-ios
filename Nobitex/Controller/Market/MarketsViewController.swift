//
//  MarketsViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import UIKit

class MarketsViewController: UIViewController {
    
    private let network = NetworkManager.shared
    private var marketData: MarketStateModel!
    
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
        
        network.getMarketStats(srcCurrency: "btc", dstCurrency: "usdt") { (success, json) in
            if success {
                DispatchQueue.main.async {
                    self.marketData = json
                    self.marketsTableView.reloadData()
                }
            }
        }
    }
}

extension MarketsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketsCell", for: indexPath) as! MarketsCell
        
        if marketData != nil {
            if marketData.stats.btcRls.dayChange.contains("-") {
                cell.dayChangeView.backgroundColor = .systemRed
                cell.dayChangePercent.text = marketData.stats.btcRls.dayChange
            } else {
                cell.backgroundColor = .systemGreen
            }
            cell.symbol.text = "BTC/USDT\n\(String(marketData.stats.btcRls.volumeDst.prefix(10)))"
            cell.latestPriceLabel.text = String(marketData.stats.btcRls.latest.prefix(5))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension MarketsViewController {
    func setMarketsTableViewConstraints() {
        NSLayoutConstraint.activate([
            marketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            marketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            marketsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            marketsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
