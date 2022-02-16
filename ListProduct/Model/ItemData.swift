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
    
    private enum CodingKeys : String, CodingKey {
        case id, title, price
        case location = "location_name"
        case isHalal = "is_halal"
        case username = "added_user_name"
        case image = "default_photo"
    }
}

struct ImageItem: Codable {
    let imagePath: String?
    
    private enum CodingKeys : String, CodingKey {
        case imagePath = "image_path"
    }
}
