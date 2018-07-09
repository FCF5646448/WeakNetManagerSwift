//
//  NoNetManager.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/19.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

class NoNetManager: NSObject {
    class func netWorking()->Bool {
        let reach = Reachability.forInternetConnection()
        if let netStatus = reach?.currentReachabilityStatus(),netStatus.rawValue != 0 {
            return true
        }else{
            return false
        }
    }
}
