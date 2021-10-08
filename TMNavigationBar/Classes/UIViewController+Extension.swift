//
//  UIViewController+Extension.swift
//  TMNavigationBar
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

// MARK: - 导航栏路由器
extension UIViewController {
    
    /// 回到上一个页面
    /// 如果没有导航控制器直接 模态
    /// 如果导航控制器只有一个后代 模态
    /// 缺省状态下 `pop` 回 上一个页面
    func tm_toPreviousViewController(animated: Bool) {
        guard let navigation = navigationController else {
            dismiss(animated: animated, completion: nil)
            return
        }
        
        if navigation.viewControllers.count == 1 {
            dismiss(animated: animated, completion: nil)
        } else {
            navigation.popViewController(animated: animated)
        }
    }
    
    class func tm_currentViewController() -> UIViewController {
        guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
            return UIViewController()
        }
        
        return tm_currentViewController(from: rootViewController)
    }
    
    /// 遍历寻找当前控制器
    class func tm_currentViewController(from fromViewController: UIViewController) -> UIViewController {
        if fromViewController.isKind(of: UINavigationController.self) {
            let nav = fromViewController as! UINavigationController
            return tm_currentViewController(from: nav.viewControllers.last!)
        } else if fromViewController.isKind(of: UITabBarController.self) {
            let tabBar = fromViewController as! UITabBarController
            return tm_currentViewController(from: tabBar.selectedViewController!)
        } else if fromViewController.presentedViewController != nil {
            return tm_currentViewController(from: fromViewController.presentingViewController!)
        } else {
            return fromViewController
        }
    }
    
}
