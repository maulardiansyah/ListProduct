//
//  BaseProgressView.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit

public class BaseProgressView {
    
    let overlayBackground: UIView = {
        let view = UIView()
        return view
    }()
    
    let indicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    static let instance = BaseProgressView()
    
    public func show(view: UIView, backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.7), style : UIActivityIndicatorView.Style = .whiteLarge) {
        view.addSubview(overlayBackground)
        overlayBackground.backgroundColor = backgroundColor
        overlayBackground.anchorSize(to: view)
        
        setupIndicator(style)
    }
    
    private func setupIndicator(_ style: UIActivityIndicatorView.Style, _ color: UIColor = .darkBlue) {
        indicator.style = style
        indicator.color = color
        indicator.startAnimating()
        overlayBackground.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(centerX: overlayBackground.centerXAnchor)
        indicator.centerYAnchor(centerY: overlayBackground.centerYAnchor)
        indicator.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }
    
    public func hide() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        overlayBackground.removeFromSuperview()
    }
}

