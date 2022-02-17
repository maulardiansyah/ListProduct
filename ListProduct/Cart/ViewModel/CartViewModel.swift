//
//  CartViewModel.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

class CartViewModel {
    
    private var cartItems = [CartItem]()
    
    var fetchedCartItem: SelectionClosure?
    var showWarnDelete: SelectionClosure?

    var numberOfCartItem: Int {
        cartItems.count
    }
    
    func viewModelCart(_ index: Int) -> CartDataViewModel? {
        guard index < cartItems.count else {
            return nil
        }
        return CartDataViewModel(cartItems[index])
    }
    
    func populateCartItem() {
        let cartItemTemp = CartData.instance.getCartItem()
        cartItems = cartItemTemp.reversed()
        fetchedCartItem?()
    }
    
    func calculateTotalPrice() -> Int {
        var totalPrice = 0
        let cartItemTemp = CartData.instance.getCartItem()
        for item in cartItemTemp {
            let totalPricePerItem = item.totalPcs * item.eachPrice
            totalPrice += Int(totalPricePerItem)
        }
        return totalPrice
    }
    
    func updatePcsCart(action: ActionCartItem, index: Int) {
        if action == .plus {
            CartData.instance.updateCart(index: index, totalPcs: 1)
        } else {
            guard cartItems[index].totalPcs > 1 else {
                showWarnDelete?()
                return
            }
            CartData.instance.updateCart(index: index, totalPcs: -1)
        }
    }
    
    func deleteItemcart(index: Int) {
        guard index < cartItems.count else { return }
        cartItems.remove(at: index)
        CartData.instance.deleteItemCart(index: index)
    }
    
    // MARK: - Add To Cart
    private func getCheckOnCart(id: String) -> Bool {
        return CartData.instance.getCheckIsOnCart(id: id)
    }
    
    func addToCart(item: ItemViewModel?) {
        let isOnCart = getCheckOnCart(id: item?.id ?? "")
        guard isOnCart == false else {
            CartData.instance.updateCart(id: item?.id ?? "")
            return
        }
        CartData.instance.addedNewCart(item: item, totalPcs: 1)
    }
}

enum ActionCartItem {
    case plus
    case minus
}
