//  十六进制颜色扩展
//  UIColor+Extension.swift
//  Swift_Weibo
//
//  Created by Tim on 2019/8/13.
//  Copyright © 2019 Tim. All rights reserved.
//

import UIKit

extension UIColor : TMCompatible {}
extension TM where Base: UIColor {
    
    /// 创建 16 进制颜色
    /// - Parameter hex: 十六进制颜色值，必须使用 0x 开头
    /// - Returns: UIColor 实例
    static func hexColor(_ hex: Int32) -> UIColor {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = (hex & 0x0000ff)
        return Base(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
    
    /// 创建 RGBA 颜色，默认不透明度为 1
    /// - Parameters:
    ///   - red:    红色值 0 ~ 255
    ///   - green:  绿色值 0 ~ 255
    ///   - blue:   蓝色值 0 ~ 255
    ///   - alpha:  透明值 0.1 ~ 1
    /// - Returns:  UIColor 实例
    static func rgbaColor(_ red: UInt8, _ green: UInt8, _ blue: UInt8, _ alpha: CGFloat = 1) -> UIColor {
        return Base(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// 随机生成一个颜色值，用于测试
    static var random : UIColor {
        UIColor.tm.rgbaColor(UInt8(arc4random() % 256), UInt8(arc4random() % 256), UInt8(arc4random() % 256))
    }
}
