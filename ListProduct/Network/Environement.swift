//
//  Environement.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import Foundation

enum Environement {
    case staging
    
    var imageUrl: String {
        switch self {
        case .staging:
            return "https://ranting.twisdev.com/uploads/"
        }
    }
    
    var apiUrl: String {
        switch self {
        case .staging:
            return "https://ranting.twisdev.com/index.php"
        }
    }
}

/// Change Environment here
var env: Environement = .staging
