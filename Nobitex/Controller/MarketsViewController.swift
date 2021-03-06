//
//  MarketsViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import UIKit

class MarketsViewController: UIViewController {
    
    private let network = NetworkManager.shared
    private var refreshControl = UIRefreshControl()
    private let marketState = MarketStateModel.shared
    private let symbolInfo = SymbolInfoViewController.shared
    private let segment: UISegmentedControl = UISegmentedControl(items: ["USDT", "IRT"])
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        setMarketsTableViewConstraints()
        addSegmentedControl()
        addRefreshControll()
        sendUsdtCoinsRequests { (success) in
            if success {
                DispatchQueue.main.async {
                    self.marketsTableView.reloadData()
                }
            }
        }
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
                cell.dayChangeView.backgroundColor = .systemGreen
            }
            
            cell.coinIcon.image = UIImage(named: marketState.symbol[indexPath.row])
            cell.coinIcon.layer.cornerRadius = 22.5
            cell.dayChangePercent.text = "\(marketState.dayChange[indexPath.row])%"
            cell.symbol.text = marketState.symbol[indexPath.row]
            
            switch segment.selectedSegmentIndex {
            case 0:
                if marketState.latestPrice[indexPath.row].last == "." {
                    cell.latestPriceLabel.text = "$\(marketState.latestPrice[indexPath.row].dropLast())"
                } else {
                    cell.latestPriceLabel.text = "$\(marketState.latestPrice[indexPath.row])"
                }
            case 1:
                if marketState.latestPrice[indexPath.row].last == "." {
                    cell.latestPriceLabel.text = "T \(marketState.latestPrice[indexPath.row].dropLast())"
                } else {
                    cell.latestPriceLabel.text = "T \(marketState.latestPrice[indexPath.row])"
                }
            default:
                break
            }
            
            cell.symbolName.text = marketState.symbolNames[marketState.symbol[indexPath.row]]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        LoadingViewController.shared.showWaiting()
        let symbolVc = SymbolInfoViewController()
        
        switch segment.selectedSegmentIndex {
        case 0:
            let symbol = "\(marketState.symbol[indexPath.row]) / USDT"
            network.getTrades(symbol: "\(marketState.symbol[indexPath.row])USDT") { (success, response) in
                if success {
                    symbolVc.symbolName = symbol
                    symbolVc.tradesModel = response
                    DispatchQueue.main.async {
                        LoadingViewController.shared.hideWaiting()
                        self.navigationController?.present(symbolVc, animated: true, completion: nil)
                    }
                }
            }
        case 1:
            let symbol = "\(marketState.symbol[indexPath.row]) / IRT"
            network.getTrades(symbol: "\(marketState.symbol[indexPath.row])IRT") { (success, response) in
                if success {
                    symbolVc.symbolName = symbol
                    symbolVc.tradesModel = response
                    DispatchQueue.main.async {
                        LoadingViewController.shared.hideWaiting()
                        self.navigationController?.present(symbolVc, animated: true, completion: nil)
                    }
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension MarketsViewController {
    func sendUsdtCoinsRequests(completion: @escaping (Bool) -> ()) {
        LoadingViewController.shared.showWaiting()
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
                                                self.network.getMarketStats(srcCurrency: "bch", dstCurrency: "usdt") { (seccess) in
                                                    if success {
                                                        self.network.getMarketStats(srcCurrency: "eos", dstCurrency: "usdt") { (seccess) in
                                                            if success {
                                                                self.network.getMarketStats(srcCurrency: "trx", dstCurrency: "usdt") { (seccess) in
                                                                    if success {
                                                                        self.network.getMarketStats(srcCurrency: "xlm", dstCurrency: "usdt") { (seccess) in
                                                                            if success {
                                                                                self.network.getMarketStats(srcCurrency: "doge", dstCurrency: "usdt") { (success) in
                                                                                    DispatchQueue.main.async { LoadingViewController.shared.hideWaiting() }
                                                                                    completion(true)
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
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sendRlsCoinsRequests(completion: @escaping (Bool) -> ()) {
        LoadingViewController.shared.showWaiting()
        network.getMarketStats(srcCurrency: "btc", dstCurrency: "rls") { (success) in
            if success {
                self.network.getMarketStats(srcCurrency: "eth", dstCurrency: "rls") { (success) in
                    if success {
                        self.network.getMarketStats(srcCurrency: "usdt", dstCurrency: "rls") { (success) in
                            if success {
                                self.network.getMarketStats(srcCurrency: "ltc", dstCurrency: "rls") { (success) in
                                    if success {
                                        self.network.getMarketStats(srcCurrency: "xrp", dstCurrency: "rls") { (success) in
                                            if success {
                                                self.network.getMarketStats(srcCurrency: "bnb", dstCurrency: "rls") { (success) in
                                                    if success {
                                                        self.network.getMarketStats(srcCurrency: "bch", dstCurrency: "rls") { (seccess) in
                                                            if success {
                                                                self.network.getMarketStats(srcCurrency: "eos", dstCurrency: "rls") { (seccess) in
                                                                    if success {
                                                                        self.network.getMarketStats(srcCurrency: "trx", dstCurrency: "rls") { (seccess) in
                                                                            if success {
                                                                                self.network.getMarketStats(srcCurrency: "doge", dstCurrency: "rls") { (success) in
                                                                                    DispatchQueue.main.async { LoadingViewController.shared.hideWaiting() }
                                                                                    completion(true)
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
    
    func addSegmentedControl() {
        
        marketState.dayChange.removeAll()
        marketState.latestPrice.removeAll()
        marketState.symbol.removeAll()
        marketsTableView.reloadData()
        
        segment.setWidth((view.frame.width / 2) - 10, forSegmentAt: 0)
        segment.setWidth((view.frame.width / 2) - 10, forSegmentAt: 1)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .allEvents)
    }
    
    func addRefreshControll() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        marketsTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        clearArrays { (clear) in
            if clear {
                switch self.segment.selectedSegmentIndex {
                case 0:
                    self.sendUsdtCoinsRequests { (success) in
                        if success {
                            DispatchQueue.main.async {
                                self.marketsTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
                case 1:
                    self.sendRlsCoinsRequests { (success) in
                        if success {
                            DispatchQueue.main.async {
                                self.marketsTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    @objc func segmentValueChanged() {
        clearArrays { (clear) in
            if clear {
                switch self.segment.selectedSegmentIndex {
                case 0:
                    self.sendUsdtCoinsRequests { (success) in
                        if success {
                            DispatchQueue.main.async {
                                self.marketsTableView.reloadData()
                            }
                        }
                    }
                case 1:
                    self.sendRlsCoinsRequests { (success) in
                        if success {
                            DispatchQueue.main.async {
                                self.marketsTableView.reloadData()
                            }
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    func clearArrays(completion: @escaping (Bool) -> ()) {
        marketState.dayChange.removeAll()
        marketState.latestPrice.removeAll()
        marketState.symbol.removeAll()
        completion(true)
    }
}
