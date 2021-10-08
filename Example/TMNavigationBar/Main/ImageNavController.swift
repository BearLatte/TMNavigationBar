//
//  ImageNavController.swift
//  TMNavigationController_Example
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ImageNavController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "玛丽莲·梦露"
        view.insertSubview(tableView, belowSubview: navigationBar)
        tableView.tableHeaderView = topView
        navigationBar.barBackgroundImage = UIImage(named: "nav_bg")
        navigationBar.isHiddBottomLine = true
        navigationBar.backgroundAlpha = 0
//        statusBarStyle = .lightContent
    }

    private lazy var tableView = { () -> UITableView in
        let table:UITableView = UITableView(frame: view.bounds, style: .plain)
        table.contentInset = .zero
        table.delegate = self
        table.dataSource = self
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        }
        return table
    }()
    
    private lazy var topView = { () -> UIImageView in
        let imageView = UIImageView(image: UIImage(named: "marilyn·monroe"))
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let navigtionBarColorChangePoint = CGFloat(220 - (isBangs ? 88.0 : 44.0) * 2)
}


extension ImageNavController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = "TMNavigatoinBar \(indexPath.row)"
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BaseViewController()
        vc.view.backgroundColor = UIColor.tm.random
        vc.title = "右滑可以查看效果"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ImageNavController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > navigtionBarColorChangePoint)
        {
            let alpha = (offsetY - navigtionBarColorChangePoint) / CGFloat(isBangs ? 88.0 : 44.0)
            navigationBar.backgroundAlpha = alpha
        }
        else
        {
            navigationBar.backgroundAlpha = 0
        }
    }
}


