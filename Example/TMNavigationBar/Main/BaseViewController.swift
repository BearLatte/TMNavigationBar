//
//  BaseViewController.swift
//  TMNavigationController_Example
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import TMNavigationBar

class BaseViewController: UIViewController {
    
    lazy var navigationBar = TMNavigationBar.navigationBar()
    
    override var title: String? {
        didSet {
            navigationBar.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.barBackgroundImage = UIImage(named: "navBg")
        navigationBar.titleColor = .white
        navigationBar.tintColor = .white
        
        if (navigationController?.children.count ?? 0) > 1 {
            navigationBar.setLeftButtonItem(normalImage: UIImage(named: "back_normal"), hightlightedImage: UIImage(named: "back_hightlight"))
        }
    }
}
