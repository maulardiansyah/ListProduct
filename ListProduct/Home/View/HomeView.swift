//
//  HomeView.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit
import SkeletonView

class HomeView: BaseVC {
    
    let svContent: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var collectionItemId = "ItemCollectionCellId"
    let collectionViewListItem: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.isSkeletonable = true
        return collectionView
    }()
    
    let containerFloatingButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.grayStroke.cgColor
        view.addShadow(offset: CGSize(width: 0, height: 4), color: .black.withAlphaComponent(0.1), opacity: 1, radius: 4)
        return view
    }()
    
    let filterButton: IconButton = {
        let iconButton = IconButton()
        iconButton.iconButton.image = .icFilter
        iconButton.labelButton.text = "Filter"
        return iconButton
    }()
    
    let categoryButton: IconButton = {
        let iconButton = IconButton()
        iconButton.iconButton.image = .icCategory
        iconButton.labelButton.text = "Category"
        return iconButton
    }()
    
    let loadMoreView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 28).isActive = true
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup View
    override func setupViews() {
        setTitle("List Product")
        setNavigationRightButtons(titles: ["cart"], icons: [.icCart])
        
        [collectionViewListItem, loadMoreView].forEach { svContent.addArrangedSubview($0) }
        [filterButton, categoryButton].forEach { containerFloatingButton.addSubview($0) }
        
        [svContent, containerFloatingButton].forEach { view.addSubview($0) }
        
        collectionViewListItem.register(ItemCollectionCell.self, forCellWithReuseIdentifier: collectionItemId)
        collectionViewListItem.dataSource = self
        collectionViewListItem.delegate = self
    }
    
    override func setupConstraints() {
        [categoryButton, filterButton].forEach {
            containerFloatingButton.addConstraintsWithFormat(format: "V:|-12-[v0(40)]-12-|", views: $0)
        }
        containerFloatingButton.addConstraintsWithFormat(format: "H:|-20-[v0(80)]-4-[v1(80)]-20-|", views: filterButton,
                                                         categoryButton)
        
        svContent.fillSuperview()
        containerFloatingButton.centerXAnchor(centerX: view.centerXAnchor)
        view.addConstraintsWithFormat(format: "V:|->=32-[v0]-28-|", views: containerFloatingButton)
        view.addConstraintsWithFormat(format: "H:|->=16-[v0]->=16-|", views: containerFloatingButton)
    }
}

//MARK: - Collection Data
extension HomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionItemId, for: indexPath) as? ItemCollectionCell else {
            fatalError("Cannot found cell id")
        }
        
        return cell
    }
}
