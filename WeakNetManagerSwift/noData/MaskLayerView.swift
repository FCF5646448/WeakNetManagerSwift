//
//  MaskLayerView.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/19.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit
import Foundation

class MaskLayerView: UIView {
    
    lazy var drawPath:UIBezierPath = {
        let path = UIBezierPath(rect: self.bounds)
        
        return path
    }()
    
    lazy var drawLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.fillColor = UIColor.white.cgColor
        layer.fillRule = kCAFillRuleEvenOdd
        return layer
    }()
    
    lazy var gradiendLayer:CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor,
            UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1).cgColor,
            UIColor(red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1).cgColor]
        return gradientLayer
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let sup = self.superview  {
            for subview in sup.subviews {
                if subview != self {
                    let ciclePath = UIBezierPath(rect: subview.frame)
                    self.drawPath.append(ciclePath)
                }
            }
            self.layer.addSublayer(self.gradiendLayer)
            self.drawLayer.path = self.drawPath.cgPath
            self.layer.addSublayer(self.drawLayer)
        }
    }
    
    override func removeFromSuperview() {
        self.gradiendLayer.removeAllAnimations()
        super.removeFromSuperview()
    }
}
