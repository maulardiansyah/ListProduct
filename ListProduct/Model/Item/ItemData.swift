//
//  ItemData.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import Foundation

struct Item: Codable {
    let id: String?
    let title, price, location: String?
    let isHalal: String?
    let username: String?
    let image: ImageItem?
    let itemWeight: String?
    let itemCondition: ConditionItem?
    
    private enum CodingKeys : String, CodingKey {
        case id, title, price
        case location = "location_name"
        case isHalal = "is_halal"
        case username = "added_user_name"
        case image = "default_photo"
        case itemWeight = "weight"
        case itemCondition = "condition_of_item"
    }
}

struct ImageItem: Codable {
    let imagePath: String?
    
    private enum CodingKeys : String, CodingKey {
        case imagePath = "img_path"
    }
}

struct ConditionItem: Codable {
    let conditionName: String?
    
    private enum CodingKeys : String, CodingKey {
        case conditionName = "name"
    }
}
