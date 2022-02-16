//
//  Service+Header.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import Alamofire

extension Services {
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .post
        }
    }
}
