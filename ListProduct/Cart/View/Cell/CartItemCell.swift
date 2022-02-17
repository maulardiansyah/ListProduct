//
//  CartItemCell.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    let imgItem: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let lblItemName: UILabel = {
        let label = UILabel()
        label.text = "Item Name"
        label.textColor = .darkBlue
        label.font = FontStyle.body(.small).font
        label.numberOfLines = 2
        return label
    }()
    
    let lblItemPrice: UILabel = {
        let label = UILabel()
        label.text = "Item Price"
        label.textColor = .orange
        label.font = FontStyle.body(.small).font
        return label
    }()
    
    let lblItemCondition: UILabel = {
        let label = UILabel()
        label.text = "Item Condition"
        label.textColor = .gray
        label.font = FontStyle.caption.font
        return label
    }()
    
    let lblTotalWeight: UILabel = {
        let label = UILabel()
        label.text = "Item Weight"
        label.textColor = .darkBlue
        label.font = FontStyle.caption.font
        label.textAlignment = .center
        return label
    }()
    
    let lblItemPcs: UILabel = {
        let label = UILabel()
        label.text = "Item Weight"
        label.textColor = .darkBlue
        label.font = FontStyle.caption.font
        label.textAlignment = .center
        return label
    }()
    
    let btnPlus: UIButton = {
        let btn = UIButton()
        btn.setImage(.icPlus, for: .normal)
        btn.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        btn.tintColor = .softGreen
        return btn
    }()
    
    let btnMinus: UIButton = {
        let btn = UIButton()
        btn.setImage(.icMinus, for: .normal)
        btn.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        btn.tintColor = .softRed
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupViews() {
        
    }
}

