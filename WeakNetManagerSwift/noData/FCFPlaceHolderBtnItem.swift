//
//  FCFPlaceHolderBtnItem.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/14.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import Foundation
import UIKit

class FCFPlaceHolderBtnItem:UIView {
    
    lazy var btn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.hexString(hex: "999999"), for: .normal)
        btn.addTarget(self, action: #selector(self.btnAction), for: .touchUpInside)
        return btn
    }()
    
    override var frame: CGRect {
        didSet{
            self.btn.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
    }
    
    
    var action:((_ btn:UIButton)->Void)?=nil
    
    //只设置title 和 action
    init(title:String,btntitleColor:UIColor = UIColor.hexString(hex: "999999"),action:((_ btn:UIButton)->Void)?=nil) {
        super.init(frame: CGRect.zero)
        self.action = action
        self.addSubview(self.btn)
        self.btn.setTitle(title, for: .normal)
        self.btn.setTitleColor(btntitleColor, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnAction(sender:UIButton){
        action?(sender)
    }
    
}


