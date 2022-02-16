//
//  CartData.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

struct CartData: Codable {
    
    let item: Item?
    var eachPrice: Int
    var eachWeight: Double
    var itemPcs: Int
}
