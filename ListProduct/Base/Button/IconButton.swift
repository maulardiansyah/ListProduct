//
//  IconButton.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

class IconButton: UIButton {
    
    let iconButton: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let labelButton: UILabel = {
        let label = UILabel()
        label.font = FontStyle.button(.small).font
        label.textColor = .darkBlue
        label.textAlignment = .center
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
        tintColor = .darkBlue
        [iconButton, labelButton].forEach { addSubview($0) }
        
        iconButton.centerXAnchor(centerX: centerXAnchor)
        addConstraintsWithFormat(format: "V:|->=0-[v0(20)]-4-[v1]->=0-|", views: iconButton, labelButton)
        addConstraintsWithFormat(format: "H:|->=0-[v0(20)]->=0-|", views: iconButton)
        addConstraintsWithFormat(format: "H:|-[v0]-|", views: labelButton)
    }
}
