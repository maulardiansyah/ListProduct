//
//  CartViewModel.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

struct CartDataViewModel {
    
    private var cartItem: CartItem
    
    init(_ cartItem: CartItem) {
        self.cartItem = cartItem
    }
    
    var itemId: String {
        return cartItem.id ?? ""
    }
    
    var itemName: String {
        return cartItem.itemName ?? ""
    }
    
    var itemCondition: String {
        return cartItem.itemCondition ?? ""
    }
    
    var imagePath: String {
        return cartItem.imagePath ?? ""
    }
    
    var itemPcs: Int {
        return Int(cartItem.totalPcs)
    }
    
    var itemWeight: String {
        let weightTemp = cartItem.eachWeight
        let weightPerKg = weightTemp / 100.0
        return "\(weightPerKg.roundToDecimal(1)) Kg"
    }
    
    var priceString: String {
        let priceTemp = Int(cartItem.eachPrice)
        return "Rp \(priceTemp.toCurrency())"
    }
}
