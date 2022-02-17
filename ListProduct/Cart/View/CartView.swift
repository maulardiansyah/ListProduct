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
        tableView.contentInset = .init(top: 20, left: 0, bottom: 8, right: 0)
        return tableView
    }()
    
    let contaierBgCart: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addShadow(location: .top)
        return view
    }()
    
    let containerRecapCart: UIView = {
        let view = UIView()
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
    
    let btnOrder: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.setTitle("Order", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    var viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        setTotalPrice()
    }
    
    // MARK: - Setup View
    override func setupViews() {
        super.setupViews()
        setTitle("Cart")
        bottombar.backgroundColor = .white
        
        /// Rounded top left and top right corner container recap cart
        if #available(iOS 11.0, *) {
            containerRecapCart.clipsToBounds = true
            containerRecapCart.layer.cornerRadius = 12
            containerRecapCart.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        [cartTableView, contaierBgCart].forEach { safeview.addSubview($0) }
        contaierBgCart.addSubview(containerRecapCart)
        [lblTotalHarga, lblTotalPriceCount, btnOrder].forEach { containerRecapCart.addSubview($0) }
        
        cartTableView.register(CartItemCell.self, forCellReuseIdentifier: tableCartCellId)
        cartTableView.dataSource = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        safeview.addConstraintsWithFormat(format: "V:|->=36-[v0]|", views: contaierBgCart)
        safeview.addConstraintsWithFormat(format: "H:|[v0]|", views: contaierBgCart)
        
        cartTableView.fillSuperview()
        containerRecapCart.fillSuperview()
        
        containerRecapCart.addConstraintsWithFormat(format: "V:|->=12-[v0]->=12-|", views: btnOrder)
        containerRecapCart.addConstraintsWithFormat(format: "V:|->=12-[v0]-4-[v1]->=12-|", views: lblTotalHarga, lblTotalPriceCount)
        [lblTotalHarga, lblTotalPriceCount].forEach { containerRecapCart.addConstraintsWithFormat(format: "H:|-20-[v0]->=12-[v1(88)]-20-|", views: $0, btnOrder) }
    }
    
    /// Update view total price
    private func setTotalPrice() {
        lblTotalPriceCount.text = "Rp \(viewModel.calculateTotalPrice().toCurrency())"
    }
    
    //MARK: - Populate Data
    private func populateData() {
        viewModel.populateCartItem()
        viewModel.fetchedCartItem = { [weak self] in
            self?.cartTableView.reloadData()
            self?.setTotalPrice()
        }
    }
}

//MARK: - Table Data
extension CartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfCartItem > 0 {
            tableView.removeEmptyView()
        } else {
            tableView.setEmptyView(img: .icCart, title: "Cart is empty", desc: "")
        }
        
        return viewModel.numberOfCartItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCartCellId, for: indexPath) as? CartItemCell else {
            fatalError("Cannot found cell")
        }
        
        cell.itemCart = viewModel.viewModelCart(indexPath.row)
        
        // Add item action
        cell.plusAction = { [weak self] in
            self?.viewModel.updatePcsCart(action: .plus, index: indexPath.row)
            self?.populateData()
        }
        
        // Minus item action
        cell.minusAction = { [weak self] in
            self?.viewModel.updatePcsCart(action: .minus, index: indexPath.row)
            self?.populateData()
        }
        
        return cell
    }
}
