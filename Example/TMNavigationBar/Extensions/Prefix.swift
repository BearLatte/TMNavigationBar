//
//  Prefix.swift
//  Prefix
//
//  Created by Tim on 2019/11/15.
//  Copyright © 2019 Tim. All rights reserved.
//

import Foundation

/// 前缀泛型类型
struct TM<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}


/// 利用协议扩展前缀
protocol TMCompatible {}
extension TMCompatible {
    var tm: TM<Self> {
        set{}
        get { TM(self) }
    }
    static var tm: TM<Self>.Type {
        set {}
        get { TM<Self>.self }
    }
}

/*
 extension String: TMCompatible {}
 extension NSString: TMCompatible {}
 extension TM where Base: ExpressibleByStringLiteral{
     var numberCount: Int {
         var count = 0
         for c in (base as! String) where ("0"..."9").contains(c){
             count += 1
         }
         return count
     }
     
     mutating func run() {
         print("可修改值的方法")
     }
     
     var isBlank : Bool {
         (base as! String).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
     }
     
 }
 */
