//
//  UIImage+Ext.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

extension UIImage {
    
    /// Icon
    class var icFilter: UIImage? { return UIImage(named: "Filter")?.withRenderingMode(.alwaysTemplate) }
    class var icCategory: UIImage? { return UIImage(named: "Category")?.withRenderingMode(.alwaysTemplate) }
    class var icLocation: UIImage? { return UIImage(named: "Location")?.withRenderingMode(.alwaysTemplate) }
    class var icUser: UIImage? { return UIImage(named: "User")?.withRenderingMode(.alwaysTemplate) }
    class var icCart: UIImage? { return UIImage(named: "ShoppingCart")?.withRenderingMode(.alwaysTemplate) }
    class var icPlus: UIImage? { return UIImage(named: "Plus")?.withRenderingMode(.alwaysTemplate) }
    class var icMinus: UIImage? { return UIImage(named: "Minus")?.withRenderingMode(.alwaysTemplate) }
    
    /// Image
    class var imgHalal: UIImage? { return UIImage(named: "Halal") }
    class var imgPlaceholder: UIImage? { return UIImage(named: "ImagePlaceholder") }
}
