//
//  EmptyView+Ext.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

extension UITableView {
    
    /// Set empty view
    func setEmptyView(img: UIImage?, title: String, desc: String) {
        let view = BaseBackgroundEmptyView()
        view.sizeToFit()
        view.img.image = img
        view.lblTitle.text = title
        view.lblDesc.text = desc
        self.backgroundView = view
    }
    
    /// Remove empty view
    func removeEmptyView() {
        self.backgroundView = nil
    }
}

extension UICollectionView {
    /// Set empty view
    func setEmptyView(img: UIImage?, title: String, desc: String) {
        let view = BaseBackgroundEmptyView()
        view.sizeToFit()
        view.img.image = img
        view.lblTitle.text = title
        view.lblDesc.text = desc
        self.backgroundView = view
    }
    
    /// Remove empty view
    func removeEmptyView() {
        self.backgroundView = nil
    }
}
