//
//  CartItemCell.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    var plusAction: SelectionClosure?
    var minusAction: SelectionClosure?
    
    let containerContent: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.grayStroke.cgColor
        view.addShadow(offset: CGSize(width: 0, height: 4), color: .black.withAlphaComponent(0.1), opacity: 1, radius: 4)
        return view
    }()
    
    let imgItem: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 12
        img.image = .imgPlaceholder
        img.clipsToBounds = true
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
        label.text = "Rp 0"
        label.textColor = .orange
        label.font = FontStyle.body(.small).font
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lblItemCondition: UILabel = {
        let label = UILabel()
        label.text = "(Baru)"
        label.textColor = .gray
        label.font = FontStyle.caption.font
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lblWeight: UILabel = {
        let label = UILabel()
        label.text = "1.0 Kg"
        label.textColor = .darkBlue
        label.font = FontStyle.caption.font
        label.textAlignment = .center
        return label
    }()
    
    let lblItemPcs: UILabel = {
        let label = UILabel()
        label.text = "1"
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
    
    let containerContentBottomRight = UIView()
    let containerContentBottom = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var itemCart: CartDataViewModel? {
        didSet {
            lblItemName.text = itemCart?.itemName
            lblItemPrice.text = itemCart?.priceString
            lblItemCondition.text = itemCart?.itemCondition
            lblWeight.text = itemCart?.itemWeight
            
            let itemPcs = itemCart?.itemPcs ?? 1
            lblItemPcs.text = "\(itemPcs)"
            btnMinus.isEnabled = itemPcs > 1 ? true : false
            btnMinus.tintColor = itemPcs > 1 ? .softRed : .gray
            
            imgItem.setImage(itemCart?.imagePath ?? "", placeholder: .imgPlaceholder)
        }
    }
    
    // MARK: - Setup View
    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .bgSoftBlue
        contentView.addSubview(containerContent)
        contentView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: containerContent)
        contentView.addConstraintsWithFormat(format: "V:|[v0]-12-|", views: containerContent)
        
        [btnMinus, lblItemPcs, btnPlus, lblWeight].forEach { containerContentBottomRight.addSubview($0) }
        
        [btnMinus, lblItemPcs, btnPlus].forEach { containerContentBottomRight.addConstraintsWithFormat(format: "V:|-2-[v0(24)]-6-[v1]->=2-|", views: $0, lblWeight) }
        containerContentBottomRight.addConstraintsWithFormat(format: "H:|[v0(24)]-[v1]-[v2(24)]|", views: btnMinus, lblItemPcs, btnPlus)
        containerContentBottomRight.addConstraintsWithFormat(format: "H:|->=8-[v0]->=8-|", views: lblWeight)
        lblWeight.centerXAnchor(centerX: containerContentBottomRight.centerXAnchor)
        
        [lblItemPrice, lblItemCondition, containerContentBottomRight].forEach { containerContentBottom.addSubview($0) }
        containerContentBottom.addConstraintsWithFormat(format: "V:|[v0]|", views: containerContentBottomRight)
        containerContentBottom.addConstraintsWithFormat(format: "V:|-4-[v0]-[v1]->=0-|", views: lblItemPrice, lblItemCondition)
        [lblItemPrice, lblItemCondition].forEach { containerContentBottom.addConstraintsWithFormat(format: "H:|[v0]->=10-[v1]|", views: $0, containerContentBottomRight) }
        
        [imgItem, lblItemName, containerContentBottom].forEach { containerContent.addSubview($0) }
        containerContent.addConstraintsWithFormat(format: "V:|-12-[v0(72)]->=12-|", views: imgItem)
        containerContent.addConstraintsWithFormat(format: "V:|-12-[v0][v1]->=12-|", views: lblItemName, containerContentBottom)
        [lblItemName, containerContentBottom].forEach {  containerContent.addConstraintsWithFormat(format: "H:|-12-[v0(72)]-10-[v1]-12-|", views: imgItem, $0) }
        
        [btnPlus, btnMinus].forEach { $0.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside) }
    }
    
    @objc
    func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnPlus:
            plusAction?()
        case btnMinus:
            minusAction?()
        default:
            return
        }
    }
}
