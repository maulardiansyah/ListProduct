//
//  IconLabel.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

class IconLabel: UIView {
    
    let iconLabel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        return image
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.font = FontStyle.body(.small).font
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        [iconLabel, labelName].forEach { addSubview($0) }
        
        addConstraintsWithFormat(format: "H:|[v0(16)]-4-[v1]|", views: iconLabel, labelName)
        addConstraintsWithFormat(format: "V:|[v0(16)]|", views: iconLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: labelName)
    }
}
