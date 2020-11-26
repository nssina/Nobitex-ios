//
//  MarketsCell.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/26/20.
//

import UIKit

class MarketsCell: UITableViewCell {

    lazy var symbol: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var latestPriceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    lazy var dayChangeView: UIView = {
       var view = UIView()
        
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dayChangePercent: UILabel = {
        var label = UILabel()
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        constraintView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubview() {
        contentView.addSubview(symbol)
        contentView.addSubview(dayChangeView)
        contentView.addSubview(latestPriceLabel)
        dayChangeView.addSubview(dayChangePercent)
    }
    
    func constraintView() {
        NSLayoutConstraint.activate([
            symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            latestPriceLabel.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            latestPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayChangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dayChangeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayChangeView.widthAnchor.constraint(equalToConstant: 80),
            dayChangeView.heightAnchor.constraint(equalToConstant: 30),
            dayChangePercent.centerXAnchor.constraint(equalTo: dayChangeView.centerXAnchor),
            dayChangePercent.centerYAnchor.constraint(equalTo: dayChangeView.centerYAnchor)
        ])
    }
}
