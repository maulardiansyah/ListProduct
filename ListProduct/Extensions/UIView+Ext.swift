//
//  UIView+Ext.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit
import Toast_Swift

/// Enum location added shadow
enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    /// To show toast view
    func showToast(_ message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom, bgColor: UIColor = UIColor.black.withAlphaComponent(0.8)) {
        var style = ToastStyle()
        style.backgroundColor = bgColor
        self.makeToast(message, duration: duration, position: position, style: style)
    }
    
    /// To make specifix radius on view
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// To add shadow of view
    func addShadow(location: VerticalLocation, color: UIColor = .black.withAlphaComponent(0.1), opacity: Float = 1, radius: CGFloat = 5.0, height: Int = -10) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: height), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    //MARK: - For set constraints
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        self.anchor(top: self.superview?.topAnchor, bottom: self.superview?.bottomAnchor, leading: self.superview?.leadingAnchor, trailing: self.superview?.trailingAnchor, padding: padding)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        }
        if let bottomAnchor = bottom {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
        }
        if let leadingAnchor = leading {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        }
        if let trailingAnchor = trailing {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerYAnchor(centerY: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    func centerXAnchor(centerX: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
    }
    
    func anchorSize(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

