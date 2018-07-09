# WeakNetManagerSwift
封装的一套无数据或者无网络的提示模板
使用：
默认样式：
```
// 默认样式 只有无数据图片和文字提示
showPlaceHold() 
```
![image](https://github.com/FCF5646448/WeakNetManagerSwift/blob/master/screenshots/nodatadefault.jpeg)

定制按钮
```
//      两个按钮 无数据
let item = FCFPlaceHolderBtnItem(title: "刷新") { (btn) in
print("xxxxx")
}
item.layer.cornerRadius = 22
item.layer.masksToBounds = true
item.btn.setTitleColor(UIColor.white, for: .normal)
item.backgroundColor = UIColor.hexString(hex: "0x00a0ea")

let item1 = FCFPlaceHolderBtnItem(title: "确定") { (btn) in
print("xxxxx")
}
item1.layer.cornerRadius = 22
item1.layer.masksToBounds = true
item1.btn.setTitleColor(UIColor.white, for: .normal)
item1.backgroundColor = UIColor.hexString(hex: "0x00a0ea")


let frame = CGRect(x:0, y:0, width: 300, height: 250)
let hintView = FCFPlaceHolderContentView(frame: frame, hasImg: true, hasPlaceLabel: true,hasBtn:true,placeBtns:[item,item1])
hintView.center = self.view.center
view.addSubview(hintView)
```
![image] (https://github.com/FCF5646448/WeakNetManagerSwift/blob/master/screenshots/noDataUIType02.jpeg)

cell蒙版样式，类似简书：
```
//cell 蒙版
let hintView = FCFPlaceHolderContentView(frame: self.view.bounds, gradLayer:true)
hintView.center = self.view.center
view.addSubview(hintView)

```
![image] (https://github.com/FCF5646448/WeakNetManagerSwift/blob/master/screenshots/WechatIMG10.jpeg)

无网络状态

![image] (https://github.com/FCF5646448/WeakNetManagerSwift/blob/master/screenshots/nonet.jpeg)
![image] (https://github.com/FCF5646448/WeakNetManagerSwift/blob/master/screenshots/nonetSet.jpeg)

