//
//  UIFont+ext.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

enum BodyFontSize {
    case small
    case regular
    case medium
}

enum ButtonFontSize {
    case small
    case regular
}

enum FontStyle {
    case title
    case body(_ size: BodyFontSize)
    case caption
    case button(_ size: ButtonFontSize)
    
    var size: CGFloat {
        switch self {
        case .title: return 20
        case .caption: return 14
        case .body(let size):
            switch size {
            case .regular, .medium:
                return 16
            case .small:
                return 14
            }
        case .button(let size):
            switch size {
            case .regular:
                return 16
            case .small:
                return 14
            }
        }
    }
    
    var font: UIFont {
        switch self {
        case .title:
            return .setFont(.title, weight: .bold)
        case .body(let size):
            switch size {
            case .medium:
                return .setFont(.body(size), weight: .medium)
            default:
                return .setFont(.body(size), weight: .regular)
            }
        case .caption:
            return .setFont(.caption, weight: .regular)
        case .button(let size):
            return .setFont(.button(size), weight: .semibold)
        }
    }
}

extension UIFont {
    class func setFont(_ style: FontStyle, weight: Weight) -> UIFont {
        return  UIFont.systemFont(ofSize: style.size, weight: weight)
    }
}
