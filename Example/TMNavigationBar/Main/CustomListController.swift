//
//  CustomListController.swift
//  TMNavigationController_Example
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class CustomListController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "自定义导航栏"
        view.insertSubview(tableView, belowSubview: navigationBar)
        tableView.contentInset = UIEdgeInsets(top: isBangs ? 88 : 44, left: 0, bottom: isBangs ? 83 : 49, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private lazy var tableView = UITableView(frame: view.bounds, style: .plain)
}

extension CustomListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var title = ""
        switch indexPath.row {
        case 0:
            title = "主页"
        case 1:
            title = "导航栏显示图片"
        default:
            break
        }
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(CustomNavController(), animated: true)
        case 1:
            navigationController?.pushViewController(ImageNavController(), animated: true)
        default:
            break
        }
    }
}
