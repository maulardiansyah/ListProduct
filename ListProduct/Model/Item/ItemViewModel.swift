//
//  ItemViewModel.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

struct ItemViewModel {
    
    private var item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    
    var id: String {
        return item.id ?? ""
    }
    
    var title: String {
        return item.title ?? ""
    }
    
    var price: Int {
        return Int(item.price ?? "0") ?? 0
    }
    
    var priceString: String {
        guard price > 0 else { return "Gratis" }
        return "Rp " + price.toCurrency()
    }
    
    var location: String {
        let locationTemp = item.location ?? ""
        return locationTemp == "" ? "-" : locationTemp
    }
    
    var username: String {
        return item.username ?? ""
    }
    
    var isHalal: Bool {
        let isHalalTemp = item.isHalal ?? "0"
        return isHalalTemp == "0" ? false : true
    }
    
    var imagePath: String {
        let imagePath = item.image?.imagePath ?? ""
        guard imagePath != "" else { return "" }
        let imageUrl = env.imageUrl + imagePath
        return imageUrl
    }
    
    var weightItem: Double {
        return Double(item.itemWeight ?? "0.0") ?? 0.0
    }
    
    var itemCondition: String {
        let conditionTemp = item.itemCondition?.conditionName ?? ""
        guard conditionTemp != "" else { return "" }
        return "(\(conditionTemp))"
    }
}
