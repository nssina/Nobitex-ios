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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var latestPriceLabel: UILabel = {
        let label = UILabel()
        
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
        contentView.addSubview(latestPriceLabel)
    }
    
    func constraintView() {
        NSLayoutConstraint.activate([
            symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            latestPriceLabel.centerYAnchor.constraint(equalTo: symbol.centerYAnchor),
            latestPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
