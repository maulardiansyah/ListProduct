//
//  Services+Path.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import Foundation

extension Services {
    
    var path: String {
        switch self {
        case .listItem:
            return "/rest/items/search/api_key/teampsisthebest/"
        }
    }
}
