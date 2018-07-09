//
//  SetGuideController.swift
//  WeakNetManagerSwift
//
//  Created by 冯才凡 on 2018/7/9.
//  Copyright © 2018年 冯才凡. All rights reserved.
//

import UIKit

class SetGuideController: UIViewController {

    lazy var bgScroller:UIScrollView = {
        let sc = UIScrollView(frame: self.view.bounds)
        sc.indexDisplayMode = .alwaysHidden
        sc.alwaysBounceVertical = true
        return sc
    }()
    
    lazy var containView:UIView = {
        let vw = UIView(frame: self.bgScroller.bounds)
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    lazy var tv:UITextView = {
        let tx = UITextView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: self.bgScroller.frame.height))
        tx.backgroundColor = UIColor.clear
        tx.attributedText = self.hintStr
        tx.delegate = self
        tx.isEditable = false
        tx.isScrollEnabled = false
        return tx
    }()
    
    lazy var hintStr:NSAttributedString = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let str = NSMutableAttributedString(string: "建议按照以下方法检查网络连接\n\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18)])
        let step1 = NSAttributedString(string: "1.打开手机“设置”并把“无线局域网”保持开启状态。\n\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.paragraphStyle:paragraphStyle])
        str.append(step1)
        
        let step2Hint = "2.打开手机“设置” - “蜂窝移动网路” — “蜂窝移动数据”,并把“BT学院”的权限设置为“WLAN与蜂窝移动网”。\n\n"
        let step2 = NSMutableAttributedString(string: step2Hint, attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.paragraphStyle:paragraphStyle])
        
        let r1 = step2Hint.range(of: "“设置” - “蜂窝移动网路” — “蜂窝移动数据”")
        step2.addAttribute(NSAttributedStringKey.link, value:"sierra://", range:(step2Hint as NSString).range(of: "“设置” - “蜂窝移动网路” — “蜂窝移动数据”"))
        str.append(step2)
        
        
        let step3 = NSAttributedString(string: "3.如果仍然无法连接网络,请检查手机是否接入互联网或咨询运营商。\n\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.paragraphStyle:paragraphStyle])
        str.append(step3)
        
        let step4 = NSAttributedString(string: "4.试试重启手机。\n\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.paragraphStyle:paragraphStyle])
        str.append(step4)
        
        return str
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        title = "设置"
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateUI(){
        self.view.addSubview(self.bgScroller)
        self.bgScroller.addSubview(self.containView)
        self.containView.addSubview(self.tv)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        let back = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = back
    }
    
    @objc func backBtnAction(){
        if self.presentingViewController == nil {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension SetGuideController:UITextViewDelegate {
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if url.scheme == "sierra" {
            let settings = UIApplicationOpenSettingsURLString
            UIApplication.shared.openURL(URL(string: settings)!)
            return false
        }
        
        return true
    }
}
