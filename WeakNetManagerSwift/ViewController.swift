//
//  ViewController.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/13.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //默认样式
//        showPlaceHold()
        
        //无数据
//        let item = FCFPlaceHolderBtnItem(title: "确定") { (btn) in
//            print("xxxxx")
//        }
//        item.layer.cornerRadius = 22
//        item.layer.masksToBounds = true
//        item.backgroundColor = UIColor.hexString(hex: "0x00a0ea")
//
//        let frame = CGRect(x:0, y:0, width: 200, height: 250)
//        let hintView = FCFPlaceHolderContentView(frame: frame, hasImg: true, hasPlaceLabel: true,hasBtn:true,placeBtns:[item])
//        hintView.center = self.view.center
//        view.addSubview(hintView)
        
        //cell 蒙版
        let hintView = FCFPlaceHolderContentView(frame: self.view.bounds, gradLayer:true)
        hintView.center = self.view.center
        view.addSubview(hintView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
}

