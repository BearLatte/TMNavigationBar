//
//  AppDelegate.swift
//  TMNavigationBar
//
//  Created by Tim on 10/08/2021.
//  Copyright (c) 2021 Tim. All rights reserved.
//

import UIKit

var isBangs: Bool {
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CustomListController())
        window?.makeKeyAndVisible()
        return true
    }
}

