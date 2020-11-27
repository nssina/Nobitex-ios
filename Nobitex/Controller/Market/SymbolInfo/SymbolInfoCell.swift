//
//  SymbolInfoCell.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/27/20.
//

import UIKit

class SymbolInfoCell: UITableViewCell {

    lazy var time: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var price: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var volume: UILabel = {
        var label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubview() {
        contentView.addSubview(time)
        contentView.addSubview(price)
        contentView.addSubview(volume)
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            price.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            price.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            volume.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            volume.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
