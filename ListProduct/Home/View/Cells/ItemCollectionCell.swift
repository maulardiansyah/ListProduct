//
//  ItemCollectionCell.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

class ItemCollectionCell: UICollectionViewCell {
    
    let imgItem: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.isSkeletonable = true
        return img
    }()
    
    let svContentLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.isSkeletonable = true
        stackView.skeletonCornerRadius = 4
        return stackView
    }()
    
    let lblItemName: UILabel = {
        let label = UILabel()
        label.text = "Item Name"
        label.textColor = .darkBlue
        label.font = FontStyle.body(.regular).font
        label.numberOfLines = 2
        return label
    }()
    
    let lblItemPrice: UILabel = {
        let label = UILabel()
        label.text = "Item Price"
        label.textColor = .orange
        label.font = FontStyle.body(.medium).font
        return label
    }()
    
    let locationLabel: IconLabel = {
        let label = IconLabel()
        label.labelName.text = "Location"
        label.iconLabel.image = .icLocation
        return label
    }()
    
    let userLabel: IconLabel = {
        let label = IconLabel()
        label.labelName.text = "User"
        label.iconLabel.image = .icUser
        return label
    }()
    
    let containerImage: UIView = UIView()
    
    let svImageHalal: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    let imgHalal: UIImageView = {
        let img = UIImageView()
        img.image = .imgHalal
        img.contentMode = .scaleAspectFit
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        img.isHidden = true
        return img
    }()
    
    let badgeItem: BadgeLabel = {
        let badge = BadgeLabel()
        badge.backgroundColor = .blueSky
        badge.text = "Shop"
        return badge
    }()
    
    let containerBottom: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupViews() {
        
        [imgItem, svContentLabel, containerBottom].forEach { contentView.addSubview($0) }
        contentView.addConstraintsWithFormat(format: "V:|[v0(120)-12-[v1]-4-[v2]-12-|", views: imgItem, svContentLabel, containerBottom)
        contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: imgItem)
        [svContentLabel, containerBottom].forEach { contentView.addConstraintsWithFormat(format: "H:|-[v0]-|", views: $0) }
        
        [lblItemName, lblItemPrice, locationLabel].forEach { svContentLabel.addArrangedSubview($0) }
        svImageHalal.addArrangedSubview(imgHalal)
        
        containerImage.addSubview(svImageHalal)
        containerImage.addConstraintsWithFormat(format: "V:|[v0]->=0-|", views: svImageHalal)
        containerImage.addConstraintsWithFormat(format: "H:|[v0]|", views: svImageHalal)
        
        [userLabel, badgeItem, containerImage].forEach { containerBottom.addSubview($0) }
        [userLabel, badgeItem].forEach { containerBottom.addConstraintsWithFormat(format: "H:|[V0]->=10-[V1]|", views: $0, containerImage) }
        containerBottom.addConstraintsWithFormat(format: "V:|[v0]->=0-|", views: containerImage)
        containerBottom.addConstraintsWithFormat(format: "V:|[v0]-[v1]->=0-|", views: userLabel, badgeItem)
        
        contentView.layer.borderWidth = 0.8
        contentView.layer.borderColor = UIColor.grayStroke.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
}
