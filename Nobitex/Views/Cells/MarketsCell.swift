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
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var symbolName: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var latestPriceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var coinIcon: UIImageView = {
        var imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
        contentView.addSubview(symbolName)
        contentView.addSubview(dayChangeView)
        contentView.addSubview(latestPriceLabel)
        contentView.addSubview(coinIcon)
        dayChangeView.addSubview(dayChangePercent)
    }
    
    
    func constraintView() {
        NSLayoutConstraint.activate([
            coinIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coinIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinIcon.widthAnchor.constraint(equalToConstant: 45),
            coinIcon.heightAnchor.constraint(equalToConstant: 45),
            
            symbol.leadingAnchor.constraint(equalTo: coinIcon.leadingAnchor, constant: 55),
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            symbol.bottomAnchor.constraint(equalTo: symbolName.topAnchor, constant: -5),
            
            symbolName.leadingAnchor.constraint(equalTo: coinIcon.leadingAnchor, constant: 55),
            symbolName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            symbolName.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 5),
            
            latestPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            latestPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            dayChangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            dayChangeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayChangeView.widthAnchor.constraint(equalToConstant: 80),
            dayChangeView.heightAnchor.constraint(equalToConstant: 30),
            
            dayChangePercent.centerXAnchor.constraint(equalTo: dayChangeView.centerXAnchor),
            dayChangePercent.centerYAnchor.constraint(equalTo: dayChangeView.centerYAnchor)
        ])
    }
}
