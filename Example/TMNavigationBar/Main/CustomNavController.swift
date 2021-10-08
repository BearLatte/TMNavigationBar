//
//  CustomNavController.swift
//  TMNavigationController_Example
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import TMNavigationBar

class CustomNavController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人中心"
        view.insertSubview(tableView, belowSubview: navigationBar)
        topView.addSubview(logoView)
        logoView.center = topView.center
        tableView.tableHeaderView = topView
        navigationBar.barBackgroundColor = UIColor.tm.random
        navigationBar.backgroundAlpha = 0
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
    
    private lazy var topView = { () -> UIView in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 260))
        view.backgroundColor = UIColor.tm.random
        return view
    }()
    
    private lazy var logoView = { () -> UIImageView in
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.frame.size = CGSize(width: 100, height: 100)
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let navigtionBarColorChangePoint = CGFloat(260 - (isBangs ? 88.0 : 44.0) * 2)
}

extension CustomNavController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "TMNvigationBar \(indexPath.row)"
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

extension CustomNavController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > navigtionBarColorChangePoint {
            let alpha = (offsetY - navigtionBarColorChangePoint) / CGFloat(isBangs ? 88.0 : 44.0)
            navigationBar.backgroundAlpha = alpha
//            UIApplication.shared.statusBarStyle = .default
        } else {
            navigationBar.backgroundAlpha = 0
            navigationBar.tintColor = .white
            navigationBar.titleColor = .white
//            statusBarStyle = .lightContent
        }
    }
}
