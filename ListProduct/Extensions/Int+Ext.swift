//
//  Int+Ext.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

extension Int {
    
    func toCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        return formattedNumber ?? ""
    }
}
