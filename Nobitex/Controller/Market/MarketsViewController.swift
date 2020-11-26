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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MarketsCell.self, forCellReuseIdentifier: "marketsCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(marketsTableView)
        
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
            cell._label.text = marketData.stats.btcRls.latest
        } else {
            cell._label.text = "Loading..."
        }
        cell._label.textColor = .yellow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Latest BTC Price"
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
