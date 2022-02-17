//
//  HomeViewModel.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

class HomeViewModel {
    
    private var listItem = [Item]()
    
    var showError: SelectionStringClosure?
    var fetchedItem: SelectionClosure?
    
    var numberOfItem: Int {
        return listItem.count
    }
    
    func viewModelItem(_ index: Int) -> ItemViewModel? {
        guard index < listItem.count else {
            return nil
        }
        return ItemViewModel(listItem[index])
    }
    
    func populateItem() {
        Network.request(.listItem) { [weak self] data, error in
            if let errorMsg = error {
                self?.showError?(errorMsg)
            } else {
                if let resData = data, let listItem = try? JSONDecoder().decode([Item].self, from: resData) {
                    self?.listItem = listItem
                } else {
                    self?.showError?("Failed to decode")
                }
            }
            
            DispatchQueue.main.async {
                self?.fetchedItem?()
            }
        }
    }
}
