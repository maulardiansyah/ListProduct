//
//  HomeView.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit
import SkeletonView

class HomeView: BaseVC {
    
    private var collectionItemId = "ItemCollectionCellId"
    let collectionViewListItem: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
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
    
    var viewModels: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateItem()
    }
    
    // MARK: - Setup View
    override func setupViews() {
        super.setupViews()
        
        setTitle("List Product")
        setNavigationRightButtons(titles: ["cart"], icons: [.icCart])
        
        [filterButton, categoryButton].forEach { containerFloatingButton.addSubview($0) }
        
        [collectionViewListItem, containerFloatingButton].forEach { view.addSubview($0) }
        
        collectionViewListItem.addSubview(refreshControl)
        collectionViewListItem.register(ItemCollectionCell.self, forCellWithReuseIdentifier: collectionItemId)
        collectionViewListItem.dataSource = self
        collectionViewListItem.delegate = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        [categoryButton, filterButton].forEach {
            containerFloatingButton.addConstraintsWithFormat(format: "V:|-12-[v0(40)]-12-|", views: $0)
        }
        containerFloatingButton.addConstraintsWithFormat(format: "H:|-20-[v0(80)]-4-[v1(80)]-20-|", views: filterButton,
                                                         categoryButton)
        
        collectionViewListItem.fillSuperview()
        containerFloatingButton.centerXAnchor(centerX: view.centerXAnchor)
        view.addConstraintsWithFormat(format: "V:|->=32-[v0]-28-|", views: containerFloatingButton)
        view.addConstraintsWithFormat(format: "H:|->=16-[v0]->=16-|", views: containerFloatingButton)
    }
    
    /// Pull to refresh
    override func refreshAction() {
        super.refreshAction()
        populateItem()
    }
    
    //MARK: - Populate Data
    func populateItem() {
        isLoading = true
        view.showAnimatedGradientSkeleton()
        
        viewModels.populateItem()
        
        viewModels.showError = { [weak self] errorMsg in
            self?.view.showToast(errorMsg)
        }
        
        viewModels.fetchedItem = { [weak self] in
            self?.isLoading = false
            self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self?.collectionViewListItem.reloadData()
        }
    }
    
}

//MARK: - Collection Data
extension HomeView: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading || viewModels.numberOfItem > 0 {
            collectionView.removeEmptyView()
        } else {
            collectionView.setEmptyView(img: .icCart, title: "Item is empty", desc: "")
        }
        
        return viewModels.numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionItemId, for: indexPath) as? ItemCollectionCell else {
            fatalError("Cannot found cell id")
        }
        cell.item = viewModels.viewModelItem(indexPath.item)
        return cell
    }
    
    /// Handling Skeleton View
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return collectionItemId
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = skeletonView.dequeueReusableCell(withReuseIdentifier: collectionItemId, for: indexPath) as? ItemCollectionCell else {
            fatalError("Cannot found cell id")
        }
        cell.isSkeletonable = true
        return cell
    }
}
