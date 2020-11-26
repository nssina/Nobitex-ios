//
//  MarketsCell.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/26/20.
//

import UIKit

class MarketsCell: UITableViewCell {

    lazy var _label: UILabel = {
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
        contentView.addSubview(_label)
    }
    
    func constraintView() {
        NSLayoutConstraint.activate([
            _label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            _label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
