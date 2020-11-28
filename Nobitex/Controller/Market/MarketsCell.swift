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
        label.textColor = .white
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
        contentView.addSubview(dayChangeView)
        contentView.addSubview(latestPriceLabel)
        contentView.addSubview(coinIcon)
        dayChangeView.addSubview(dayChangePercent)
    }
    
    func constraintView() {
        NSLayoutConstraint.activate([
            coinIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            coinIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinIcon.widthAnchor.constraint(equalToConstant: 30),
            coinIcon.heightAnchor.constraint(equalToConstant: 30),
            symbol.leadingAnchor.constraint(equalTo: coinIcon.leadingAnchor, constant: 40),
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            latestPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            latestPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayChangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dayChangeView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayChangeView.widthAnchor.constraint(equalToConstant: 80),
            dayChangeView.heightAnchor.constraint(equalToConstant: 30),
            dayChangePercent.centerXAnchor.constraint(equalTo: dayChangeView.centerXAnchor),
            dayChangePercent.centerYAnchor.constraint(equalTo: dayChangeView.centerYAnchor)
        ])
    }
}
