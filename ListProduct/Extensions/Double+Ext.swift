//
//  Double+Ext.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
