//
//  CartViewModel.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

struct CartDataViewModel {
    
    private var cartItem: CartData
    
    init(_ cartItem: CartData) {
        self.cartItem = cartItem
    }
    
    var itemId: String {
        return cartItem.itemId
    }
    
    var itemDetail: ItemViewModel {
        return cartItem.item
    }
    
    var itemPcs: Int {
        return cartItem.itemPcs
    }
    
    var totalWeight: String {
        let weightTemp = cartItem.eachWeight
        let weightPerKg = weightTemp / 100.0
        let totalWeight = weightPerKg * Double(itemPcs)
        return "\(totalWeight.roundToDecimal(1)) Kg"
    }
    
    var totalPriceString: String {
        let priceTemp = cartItem.eachPrice
        let totalPrice = priceTemp * itemPcs
        return "Rp \(totalPrice.toCurrency())"
    }
    
    var totalPrice: Int {
        let priceTemp = cartItem.eachPrice
        let totalPrice = priceTemp * itemPcs
        return totalPrice
    }
}
