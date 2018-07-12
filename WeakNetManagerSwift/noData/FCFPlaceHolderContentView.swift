//
//  FCFPlaceHolderContentView.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/6/15.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

//contentView
class FCFPlaceHolderContentView:UIView {
    
    //MARK: 主要显示控件相关属性
    //图片
    lazy var ndBgImgView:UIImageView = {
        let imgview = UIImageView()
        imgview.image = self.ndBgImg
        imgview.contentMode = self.ndBgImgMode
        imgview.frame = self.ndBgImgViewFrame ??  CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*3/5)
        return imgview
    }()
    //提示文本
    lazy var ndHintLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = self.ndPlaceholderTextAlign
        label.textColor = UIColor.hexString(hex: self.ndPlaceholderTextColor)
        label.font = UIFont.systemFont(ofSize: self.ndPlaceholderTextSize)
        if self.ndPlaceHolderAttri != nil {
            label.attributedText = self.ndPlaceHolderAttri
        }else{
            label.text = self.ndPlaceholder
        }
        label.frame = self.ndHintLabelFrame ?? CGRect(x: 0, y: self.ndBgImgView.frame.maxY + LineSpacing, width: self.frame.width, height: 44)
        return label
    }()
    //按钮  最多两个按钮
    var ndBtns:[FCFPlaceHolderBtnItem] = []
    lazy var ndBtnsView:UIView = {
        let view = UIView()
        view.frame = self.ndBtnsFrame ??  CGRect(x: 0, y: (self.frame.maxY - 44), width: self.frame.width, height: 44)
        return view
    }()
    
    //滚动视图 cell 或者 webview
    lazy var ndScrollView:NoDataScrollview = {
        return NoDataScrollview(frame: self.bounds,type:.cell)
    }()
    
    //无网络的view
    lazy var noNetView:UIView = {
        let v = UIView(frame: self.bounds)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    //无数据提醒的view
    lazy var noDataView:UIView = {
        let v = UIView(frame: self.bounds)
        v.backgroundColor = UIColor.white
        return v
    }()
    
    //MARK: 图片相关属性
    //default img
    var ndBgImg:UIImage = UIImage(named: "nodata")!
    //default img Mode
    var ndBgImgMode:UIViewContentMode = .scaleAspectFit
    
    
    //MARK: 文本相关属性
    //default text
    var ndPlaceholder:String = "没有相关数据哦😊"
    //text AttributedString
    var ndPlaceHolderAttri:NSAttributedString?
    //default textColor
    var ndPlaceholderTextColor:String = "999999"
    //default textSize
    var ndPlaceholderTextSize:CGFloat = 14
    //default textAlign
    var ndPlaceholderTextAlign:NSTextAlignment = .center
    
    
    //MARK:布局相关属性 默认的样式从上到下：Img-label-btn
    var LineSpacing:CGFloat = 10
    var ndBgImgViewFrame:CGRect?
    var ndHintLabelFrame:CGRect?
    var ndBtnsFrame:CGRect?
    
    
    
    //MARK:外部初始化接口 默认的样式从上到下：Img-label-btn
    /*
     hasImg~imgMode 图片相关
     hasPlaceLabel~labelFrame 文本相关 placehold和 phAttriStr只有可能存在一种
     hasBtn~ndBtnsFrame 按钮相关
     gradLayer 显示渐变层相关 一般用于cell和webview
     */
    init(frame:CGRect,
         hasImg:Bool = true,
         bgimg:UIImage?=nil,
         imgHeight:CGFloat?=nil,
         imgMode:UIViewContentMode?=nil,
         hasPlaceLabel:Bool = true,
         placehold:String?=nil,
         phAttriStr:NSAttributedString?=nil,
         textColor:String?=nil,
         textSize:CGFloat?=nil,
         textAlign:NSTextAlignment?=nil,
         labelHeight:CGFloat?=nil,
         hasBtn:Bool = false,
         placeBtns:[FCFPlaceHolderBtnItem]?=nil,
         ndBtnsHeight:CGFloat?=nil,
         gradLayer:Bool=false) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: nil)
        
        if let bgimg = bgimg {
            self.ndBgImg = bgimg
        }
        if let bgimgMode = imgMode {
            self.ndBgImgMode = bgimgMode
        }
        if let imgH = imgHeight {
            self.ndBgImgViewFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: imgH)
        }
        
        if let ph = placehold {
            self.ndPlaceholder = ph
        }
        if let tc = textColor {
            self.ndPlaceholderTextColor = tc
        }
        if let ts = textSize {
            self.ndPlaceholderTextSize = ts
        }
        if let ta = textAlign {
            self.ndPlaceholderTextAlign = ta
        }
        if let labH = labelHeight {
            self.ndHintLabelFrame = CGRect(x: 0, y: (hasImg ? self.ndBgImgView.frame.maxY+LineSpacing : 0), width: self.frame.width, height: labH)
        }
        if placeBtns != nil {
            self.ndBtns = placeBtns!
        }
        if let bH = ndBtnsHeight {
            self.ndBtnsFrame = CGRect(x: 0, y: self.frame.maxY - bH, width: self.frame.width, height: bH)
        }
        
        if gradLayer {
            self.addSubview(self.ndScrollView)
        }else{
            self.updateUI(hasImg: hasImg, hasPlaceLabel: hasPlaceLabel,hasBtn: hasBtn)
        }
        
        if !NoNetManager.shareInstance.netWorking() { //没网
            addNoNetView()
            return
        }
    }
    
    func addNoNetView(){
        
        self.noNetView.removeFromSuperview()
        self.addSubview(self.noNetView)
        
        
        let top:CGFloat = self.frame.height - 130 - 48 - 44
        let topy = top/2.0
        
        
        let imgview = UIImageView()
        imgview.image = UIImage(named: "nowifi")!
        imgview.contentMode = .scaleAspectFit
        imgview.frame = CGRect(x: 0, y: topy, width: self.frame.width, height: 130)
        self.noNetView.addSubview(imgview)
        
        
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = self.ndPlaceholderTextAlign
        label.textColor = UIColor.hexString(hex: self.ndPlaceholderTextColor)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "无法获取网络内容\n请查看网络设置"
        label.frame = CGRect(x: 0, y: self.ndBgImgView.frame.maxY, width: self.frame.width, height: 48)
        self.noNetView.addSubview(label)
        
        let ndBtnsview = UIView()
        ndBtnsview.frame = CGRect(x: 0, y: self.ndHintLabel.frame.maxY+LineSpacing, width: self.frame.width, height: 44)
        self.noNetView.addSubview(ndBtnsview)
        
        let item = FCFPlaceHolderBtnItem(title: "网络诊断",btntitleColor:UIColor.white) { (btn) in
            let vc = SetGuideController()
            if let baseVC = self.firstController() {
                if baseVC.navigationController == nil {
                    let nav = UINavigationController(rootViewController: vc)
                    baseVC.present(nav, animated: true, completion: nil)
                }else{
                    vc.hidesBottomBarWhenPushed = true
                    baseVC.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        item.layer.cornerRadius = 22
        item.layer.masksToBounds = true
        item.backgroundColor = UIColor.hexString(hex: "0x00a0ea")
        let btnw =  (ndBtnsview.frame.width > (136 + 20) ? 136 :ndBtnsview.frame.width-20)
        item.frame = CGRect(x: (ndBtnsview.frame.width - btnw)/2.0, y: 0, width: btnw, height: 44)
        ndBtnsview.addSubview(item)
        self.bringSubview(toFront: self.noNetView)
    }
    
    @objc func reachabilityChanged(_ notificate:Notification) {
        
        if let cursh:Reachability = notificate.object as? Reachability {
            switch cursh.currentReachabilityStatus(){
            case NetworkStatus.init(0):
                addNoNetView()
                print("无网络")
                break
            case NetworkStatus.init(1):
                self.noNetView.removeFromSuperview()
                print("wifi")
                break
            case NetworkStatus.init(2):
                self.noNetView.removeFromSuperview()
                print("蜂窝")
                break
            default:
                break
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
    }
    
}

extension FCFPlaceHolderContentView{
    func updateUI(hasImg:Bool,hasPlaceLabel:Bool,hasBtn:Bool){
        self.noDataView.removeFromSuperview()
        self.insertSubview(self.noDataView, at: 0)
        if hasImg {
            //添加image
            self.noDataView.addSubview(self.ndBgImgView)
        }
        if hasPlaceLabel {
            self.noDataView.addSubview(self.ndHintLabel)
        }
        if hasBtn {
            self.noDataView.addSubview(self.ndBtnsView)
            
            let count = self.ndBtns.count > 3 ? self.ndBtns.count : self.ndBtns.count
            for (index, item) in self.ndBtns.enumerated() {
                if index > 2 {break}
                if count == 1 {
                   let btnw =  (self.ndBtnsView.frame.width > (136 + 20) ? 136 : self.ndBtnsView.frame.width-20)
                    item.frame = CGRect(x: (self.ndBtnsView.frame.width - btnw)/2.0, y: 0, width: btnw, height: 44)
                }else if count == 2 {
                    let btnw =  (self.ndBtnsView.frame.width > (136*2 + 30) ? 136 : (self.ndBtnsView.frame.width-30)/2.0)
                    item.frame = CGRect(x: 10+(btnw+10)*CGFloat(index), y: 0, width: btnw, height: 44)
                }else{
                    let btnw = (self.ndBtnsView.frame.width-40)/3.0
                    item.frame = CGRect(x: 10+(btnw+10)*CGFloat(index), y: 0, width: btnw, height: 44)
                }
                self.ndBtnsView.addSubview(item)
            }
        }
    }
}

extension UIViewController {
    func showPlaceHold(){
        let frame = CGRect(x:0, y:0, width: 200, height: 250)
        let hintView = FCFPlaceHolderContentView(frame: frame, hasImg: true, hasPlaceLabel: true)
        hintView.center = self.view.center
        view.addSubview(hintView)
    }
}
