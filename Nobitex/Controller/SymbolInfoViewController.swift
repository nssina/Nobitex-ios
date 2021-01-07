//
//  SymbolInfoViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/27/20.
//

import UIKit

class SymbolInfoViewController: UIViewController {
    
    static let shared = SymbolInfoViewController()
    private let timeConverter = TimeConverter.shared
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
        
        view.addSubview(symInfoTableView)
        setSymInfoConstraints()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        self.view.addSubview(navigationBar);
        let navigationItem = UINavigationItem(title: symbolName)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneBtn
        navigationBar.setItems([navigationItem], animated: false)
    }
}

extension SymbolInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradesModel.trades.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symbolInfoCell", for: indexPath) as! SymbolInfoCell
        
        DispatchQueue.main.async {
            cell.price.text = self.tradesModel.trades[indexPath.row].price
            
            cell.time.text = self.timeConverter.setTimestamp(epochTime: self.tradesModel.trades[indexPath.row].time)
            
            if self.tradesModel.trades[indexPath.row].type == "sell" {
                cell.price.textColor = .systemRed
            } else {
                cell.price.textColor = .systemGreen
            }
            
            cell.volume.text = self.tradesModel.trades[indexPath.row].volume
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SymbolInfoViewController {
    func setSymInfoConstraints() {
        NSLayoutConstraint.activate([
            symInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            symInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            symInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            symInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
