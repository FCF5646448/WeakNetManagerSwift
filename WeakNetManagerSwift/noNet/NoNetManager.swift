//
//  NoNetManager.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/19.
//  Copyright © 2018年 冯才凡. All rights reserved.
//


import UIKit

class NoNetManager: NSObject {

    let reach = Reachability.forInternetConnection()
    
    static let shareInstance = NoNetManager()
    
    private override init() {
        super.init()
        self.reach?.startNotifier() //要记得添加进SystemConfiguration.framework才能监听到网络变化
    }
    
    func netWorking()->Bool {
        if let netStatus = reach?.currentReachabilityStatus(),netStatus.rawValue != 0 {
            return true
        }else{
            return false
        }
    }
}
