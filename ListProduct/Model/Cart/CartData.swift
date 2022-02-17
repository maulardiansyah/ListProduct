//
//  CartData.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import CoreData

class CartData: CoreDataBrain {
    
    static let instance = CartData()
    
    //MARK: - CREATE
    func initCart(_ debug: Bool) {
        let requestCart: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        
        do {
            let cartItem = try context.fetch(requestCart)
            if cartItem.isEmpty {
                /// apabila belum ada data di coredata, maka buat baru
                _ = CartItem(context: context)
                
                saveData()
            }
        } catch {
            print("Error create first list favorite games: \(error)")
        }
    }

    //MARK: - Input Data
    func addedNewCart(item: ItemViewModel?, totalPcs: Int) {
        let requestCart: NSFetchRequest<CartItem> = CartItem.fetchRequest()

        do {
            let fetchCart = try context.fetch(requestCart)

            if fetchCart.isEmpty {
                let cartItem = CartItem(context: context)
                cartItem.id = item?.id
                cartItem.itemName = item?.title
                cartItem.eachPrice = Int32(item?.price ?? 0)
                cartItem.eachWeight = item?.weightItem ?? 0.0
                cartItem.imagePath = item?.imagePath
                cartItem.totalPcs = Int32(totalPcs)
                cartItem.itemCondition = item?.itemCondition
            } else {
                insertNewItemCart(item: item, totalPcs: totalPcs)
            }

        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func insertNewItemCart(item: ItemViewModel?, totalPcs: Int) {
        var listCart = getCartItem()
        if let cartItem = NSEntityDescription.insertNewObject(forEntityName: "CartItem", into: context) as? CartItem {
            cartItem.id = item?.id
            cartItem.itemName = item?.title
            cartItem.eachPrice = Int32(item?.price ?? 0)
            cartItem.eachWeight = item?.weightItem ?? 0.0
            cartItem.imagePath = item?.imagePath
            cartItem.totalPcs = Int32(totalPcs)
            cartItem.itemCondition = item?.itemCondition
            listCart.append(cartItem)
        }

        saveData()
    }
    
    //MARK: - READ
    func getCartItem() -> [CartItem] {
        let requestCart: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        requestCart.returnsObjectsAsFaults = false
        
        var listCart = [CartItem]()
        
        do {
            listCart = try context.fetch(requestCart)
        } catch {
            print("Error get all games favorite: \(error)")
        }
        
        return listCart
    }
    
    //MARK: - UPDATE
    func updateCart(id: String) {
        let currentCart = getCartItem()
        let itemCart = currentCart.filter({ $0.id == id })
        guard itemCart.count > 0 else { return }
        let itemTemp = itemCart[0]
        var pcs = itemTemp.totalPcs
        pcs += 1
        itemTemp.setValue(pcs, forKey: "totalPcs")
        saveData()
    }
    
    func updateCart(index: Int, totalPcs: Int) {
        let currentCart = getCartItem()
        guard index < currentCart.count else { return }
        let itemCart = currentCart[index]
        var pcs = itemCart.totalPcs
        pcs += Int32(totalPcs)
        itemCart.setValue(pcs, forKey: "totalPcs")
        saveData()
    }
    
    //MARK: - Check is already on cart
    func getCheckIsOnCart(id: String) -> Bool {
        let currentCart = getCartItem()
        let stateContains = currentCart.contains(where: { $0.id == id } )
        return stateContains
    }
    
    //MARK: - Delete
    func deleteItemCart(id: String) {
        let currentCart = getCartItem()
        let itemCart = currentCart.filter({ $0.id == id })
        guard itemCart.count > 0 else { return }
        context.delete(currentCart[0])
        saveData()
    }
    
    func deleteItemCart(index: Int) {
        let currentCart = getCartItem()
        guard index < currentCart.count else { return }
        context.delete(currentCart[index])
        saveData()
    }
}
