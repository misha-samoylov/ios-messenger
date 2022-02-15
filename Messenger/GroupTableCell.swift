//
//  GroupTableCell.swift
//  Messenger
//
//  Created by Misha Samoylov on 15.02.2022.
//

import UIKit

class GroupTableCell: UITableViewCell {

    var labelName = UILabel()
    
    // Используем перезапись функции инициализации
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(labelName)
        
        labelName.textAlignment = .center
        labelName.textColor = .black
        
        labelName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        labelName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 16).isActive = true
        labelName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        labelName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        labelName.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
