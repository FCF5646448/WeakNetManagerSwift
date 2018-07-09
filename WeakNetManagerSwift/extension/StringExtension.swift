//
//  StringExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/6/4.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {
    public func width(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            context: nil)
        return ceil(boundingBox.width)
    }
    
    public func height(width:CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return ceil(boundingBox.height)
    }
}


extension String {
    /**
     计算文字宽高
     - returns:
     //使用：
     let projectText="我是一段字符串，来计算我的高度吧";
     
     let projectSize=projectText.textSizeWithFont(UIFont.systemFontOfSize(14), constrainedToSize:CGSizeMake(100, 200))
     let comProjectW:CGFloat=projectSize.width;
     let comProjectH:CGFloat=projectSize.height;
     //记得要在计算的字符串UILable中加上
     UIlable.font=UIFont.systemFontOfSize(14);
     //显示几行
     UIlable.numberOfLines=1;
     */
    
    func textSizeWithFont(_ font:UIFont,constrainedToSize size:CGSize) -> CGSize{
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            textSize = self.size(withAttributes: [NSAttributedStringKey.font:font])
        }else{
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let stringRect = self.boundingRect(with: size,options: option,attributes: [NSAttributedStringKey.font:font],context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
}
