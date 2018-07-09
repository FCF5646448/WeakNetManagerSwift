//
//  NoDataHintSCrollViewCell.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/19.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

class NoDataHintSCrollViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let maskLayer = MaskLayerView(frame: self.bounds)
        self.contentView.addSubview(maskLayer)
        maskLayer.boundInside(self.contentView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}


