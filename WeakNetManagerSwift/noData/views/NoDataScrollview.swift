//
//  NoDataScrollview.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/14.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

enum NoDataType {
    case cell
    case web
}

class NoDataScrollview:UIScrollView {
    
    init(frame: CGRect,type:NoDataType) {
        super.init(frame: frame)
        self.contentSize = CGSize(width: self.frame.width, height: self.frame.height + 0.5)
        
        switch type {
        case .cell:
            let cellheight:CGFloat = 100
            let count:Int = Int(self.frame.height/cellheight)
            
            for i in 0..<(count + 1) {
                let cell:NoDataHintSCrollViewCell = Bundle.main.loadNibNamed("NoDataHintSCrollViewCell", owner: self, options: nil)?.first as! NoDataHintSCrollViewCell
                cell.frame = CGRect(x: 0, y: cellheight*CGFloat(i), width: self.bounds.width, height: cellheight)
                self.addSubview(cell)
            }
            break
        case .web:
            
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
