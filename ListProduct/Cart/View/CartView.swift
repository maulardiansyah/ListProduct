//
//  CartView.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import UIKit

class CartView: BaseVC {
    
    let tableCartCellId = "tableCartCellId"
    let cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let containerRecapCart: UIView = {
        let view = UIView()
        view.addShadow(location: .top)
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.grayStroke.cgColor
        view.roundCorners(corners: .topLeft, radius: 8)
        view.roundCorners(corners: .topRight, radius: 8)
        view.backgroundColor = .white
        return view
    }()
    
    let lblTotalHarga: UILabel = {
        let label = UILabel()
        label.text = "Total Harga"
        label.textColor = .darkBlue
        label.font = FontStyle.body(.medium).font
        label.numberOfLines = 2
        return label
    }()
    
    let lblTotalPriceCount: UILabel = {
        let label = UILabel()
        label.text = "Rp 0"
        label.textColor = .orange
        label.font = FontStyle.body(.medium).font
        return label
    }()
}
