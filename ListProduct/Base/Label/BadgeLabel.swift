//
//  BadgeLabel.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

class BadgeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = .white
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false // enables auto layout
        font = FontStyle.caption.font
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = 4
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 16, height: height)
    }
}
