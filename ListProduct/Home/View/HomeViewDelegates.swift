//
//  HomeViewDelegates.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

//MARK: - Collection Delegate
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModels.viewModelItem(indexPath.item)
        cartViewModel.addToCart(item: item)
        view.showToast("\(item?.title ?? "") added item to cart")
    }
}

//MARK: - Collection View Flow Layout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: (screenWidth/2)-16, height: 280)
    }
}
