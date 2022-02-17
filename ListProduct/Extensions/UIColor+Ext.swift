//
//  UIColor+Ext.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

extension UIColor {
    
    class public var bgSoftBlue: UIColor { UIColor.UIColorRGB(rgbValue: 0xF5F7FF) }
    class public var darkBlue: UIColor { UIColor.UIColorRGB(rgbValue: 0x1b2769) }
    class public var blueSky: UIColor { UIColor.UIColorRGB(rgbValue: 0x51A0EE) }
    class public var gray: UIColor { UIColor.UIColorRGB(rgbValue: 0x666666) }
    class public var grayStroke: UIColor { UIColor.UIColorRGB(rgbValue: 0xE2E7FF) }
    
    class public var softGreen: UIColor { UIColor.UIColorRGB(rgbValue: 0x4BAAB9) }
    class public var softRed: UIColor { UIColor.UIColorRGB(rgbValue: 0xED6B66) }
    
    /// Set color using hex RGB value
    class func UIColorRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            displayP3Red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}
