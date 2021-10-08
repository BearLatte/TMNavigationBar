//
//  Constant.swift
//  TMNavigationBar
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

struct Constant {
    /// 判断设备是否有刘海
    static var isBangs: Bool {
        if UIDevice.current.model == "iPad" {
            return false
        }
        
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.delegate?.window,
                  let unwrapedWindow = window else {
                      return false
                  }
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }
    
    /// 导航栏高度
    static var navigationBarHeight: CGFloat {
        isBangs ? 88.0 : 64.0
    }
    
    /// tabBar 高度
    static var tabBarHeight: CGFloat {
        isBangs ? 83.0 : 49.0
    }
    
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    /// 屏幕高度
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
