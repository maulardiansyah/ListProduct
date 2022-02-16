//
//  BaseVC.swift
//  ListProduct
//
//  Created by Maul on 16/02/22.
//

import UIKit
import SkeletonView

class BaseVC: UIViewController {
    
    let statusbar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let bottombar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let safeview: UIView = {
        let view = UIView()
        view.backgroundColor = .bgSoftBlue
        return view
    }()
    
    let scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let container: UIView = {
        let view = UIView()
        return view
    }()
    
    let innerScrollview: UIView = {
        let view = UIView()
        return view
    }()
    
    let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return view
    }()
    
    let progressView = BaseProgressView()
    
    var titleText = ""
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigation()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// remove title on back button
        navigationItem.title = " "
    }
    
    func setNavigation(barTintColor: UIColor = .white, tintColor: UIColor = .darkBlue) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        
        if #available(iOS 15.0, *)  {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = barTintColor
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
        }
    }
    
    func setTitle(_ title: String, titleColor: UIColor = .black) {
        let navbarH = self.navigationController?.navigationBar.frame.height ?? 0
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: navbarH))
        label.textAlignment = .left
        label.text = title
        label.numberOfLines = 0
        label.textColor = titleColor
        
        let attributText = NSMutableAttributedString()
        let boldAttrs = [NSAttributedString.Key.font : FontStyle.title.font]
        let boldAttributedString = NSMutableAttributedString(string: title, attributes: boldAttrs as [NSAttributedString.Key: Any])
        attributText.append(boldAttributedString)

        label.attributedText = attributText
        navigationItem.titleView = label
    }
    
    func setNavigationRightButtons(titles: [String], icons: [UIImage?]) {
        var rightButtonItem = [UIBarButtonItem?](repeating: nil, count: titles.count)
        for index in 0 ..< rightButtonItem.count {
            if icons.count > 0 {
                rightButtonItem[index] = UIBarButtonItem(image: icons[index]?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(rightButtonPressed(sender:)))
                rightButtonItem[index]?.title = titles[index]
            } else {
                rightButtonItem[index] = UIBarButtonItem(title: titles[index], style: .plain, target: self, action: #selector(rightButtonPressed(sender:)))
            }
        }
        navigationItem.rightBarButtonItems = rightButtonItem as? [UIBarButtonItem]
    }
    
    @objc
    func rightButtonPressed(sender : UIBarButtonItem) { }
    
    func toNext(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func toPrev() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        view.isSkeletonable = true
        safeview.isSkeletonable = true
        
        view.backgroundColor = .bgSoftBlue
        view.addSubview(statusbar)
        view.addSubview(safeview)
        view.addSubview(bottombar)
        
        /// pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    func setupConstraints() {
        var bottomConstraint: NSLayoutConstraint?
        if #available(iOS 11.0, *) {
            let safeViews = view.safeAreaLayoutGuide
            statusbar.anchor(top: view.topAnchor, bottom: safeViews.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            safeview.anchor(top: safeViews.topAnchor, bottom: nil, leading: safeViews.leadingAnchor, trailing: safeViews.trailingAnchor, padding: .zero)
            bottombar.anchor(top: safeViews.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            bottomConstraint = NSLayoutConstraint(item: safeview, attribute: .bottom, relatedBy: .equal, toItem: safeViews, attribute: .bottom, multiplier: 1, constant: 0)
        } else {
            let sf = view
            statusbar.anchor(top: view.topAnchor, bottom: sf?.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            safeview.anchor(top: sf?.topAnchor, bottom: nil, leading: sf?.leadingAnchor, trailing: sf?.trailingAnchor, padding: .zero)
            bottombar.anchor(top: sf?.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .zero)
            bottomConstraint = NSLayoutConstraint(item: safeview, attribute: .bottom, relatedBy: .equal, toItem: sf, attribute: .bottom, multiplier: 1, constant: 0)
        }
        view.addConstraint(bottomConstraint!)
    }
    
    func alertInfo(_ title: String = "", msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            self?.alertAction()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func refreshAction() {
        refreshControl.endRefreshing()
    }
    
    @objc
    func buttonPressed(_ sender: UIButton) { }
    
    @objc
    func alertAction() { }
}
