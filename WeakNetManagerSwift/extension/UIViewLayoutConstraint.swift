//
//  UIViewLayoutConstraint.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/19.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func boundInside(_ superView:UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        let hlc = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":self])
        superView.addConstraints(hlc)
     
        let vlc = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":self])
        superView.addConstraints(vlc)
    }
    
    //获取任意试图view所属视图控制器UIViewController
    func firstController()->UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let response = view?.next {
                if response.isKind(of: UIViewController.self) {
                    return response as? UIViewController
                }
            }
        }
        return nil
    }
    
}
