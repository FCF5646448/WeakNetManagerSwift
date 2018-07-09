//
//  UIColorExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/6/4.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    //16进制字符串设置颜色
    class func hexString(hex:String) -> UIColor {
        if hex == "0" {
            return UIColor.clear //如果为"0",就认为是透明色
        }
        let scanner:Scanner = Scanner(string: hex)
        var valueRGB:UInt32 = 0
        if scanner.scanHexInt32(&valueRGB) == false {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }else{
            return UIColor.init(
                red: CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green: CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue: CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha: CGFloat(1.0))
        }
    }
}
