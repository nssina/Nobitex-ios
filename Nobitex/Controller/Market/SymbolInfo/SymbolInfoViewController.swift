//
//  SymbolInfoViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/27/20.
//

import UIKit

class SymbolInfoViewController: UIViewController {
    
    static let shared = SymbolInfoViewController()
    
    var tradesModel: TradesModel!
    var symbolName: String = ""
    
    private lazy var symInfoTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(SymbolInfoCell.self, forCellReuseIdentifier: "symbolInfoCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(symbolName)
        
    }
}

extension SymbolInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symbolInfoCell", for: indexPath) as! SymbolInfoCell
        
        return cell
    }
}

extension SymbolInfoViewController {
    func setMarketsTableViewConstraints() {
        NSLayoutConstraint.activate([
            symInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            symInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            symInfoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            symInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
