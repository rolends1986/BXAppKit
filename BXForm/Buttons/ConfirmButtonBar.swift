//
//  ConfirmButtonBar.swift
//
//  Created by Haizhen Lee on 15/6/4.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//


import BXiOSUtils
import UIKit
import SwiftyJSON
import BXModel

public enum ConfirmButtonBarStyle{
  case plain
  case bordered
  
  var isPlain:Bool{
    return self == .plain
  }
}

// -ConfirmButtonBar:v
// cancel[h34,w102,y,x35](cdt):b;ok[h34,w102,y,x35](cw):b
public typealias OnCancelHandler = (() -> Void)
public typealias OnOkHandler = (() -> Void)

open class ConfirmButtonBar : UIView{
    public let cancelButton = UIButton(type:.system)
    public let okButton = UIButton(type:.system)
  open var onCancelHandler:OnCancelHandler?
  open var onOkHandler:OnOkHandler?
  var style:ConfirmButtonBarStyle = .plain
  public  init(style:ConfirmButtonBarStyle){
    super.init(frame:CGRect.zero)
    self.style = style
    commonInit()
  }
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [cancelButton,okButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [cancelButton,okButton]
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    if style.isPlain{
      cancelButton.pa_leading.eq(15).install()
      okButton.pa_trailing.eq(15).install()
      for button in [okButton,cancelButton]{
        button.pa_width.gte(40).install()
        button.pa_centerY.install()
      }
    }else{
    cancelButton.pa_centerY.install()
    cancelButton.pa_height.eq(34).install()
    cancelButton.pa_width.eq(102).install()
    cancelButton.pa_trailing.equalTo(.centerX, ofView: self).eq(dp2dp(40)).install() //  pinTrailingToCenterX(dp2dp(40))
    
    okButton.pa_centerY.install()
    okButton.pa_height.eq(34).install()
    okButton.pa_width.eq(102).install()
    okButton.pa_leading.eq(dp2dp(40)).equalTo(.centerX, ofView: self).install()
    }
    
  }
  
  func setupAttrs(){
    cancelButton.setTitle(i18n("取消"), for: .normal)
    okButton.setTitle(i18n("确定"), for: .normal)

    
    if style.isPlain{
      cancelButton.setTitleColor(FormColors.tertiaryTextColor, for: .normal)
      okButton.setTitleColor(UIColor(hex: 0xf23d3d), for: .normal)
      
      for button in [okButton,cancelButton]{
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      }
    }else{
      cancelButton.setTitleColor(UIColor.darkText, for: .normal)
      okButton.setTitleColor(UIColor.white, for: .normal)
      cancelButton.setBackgroundImage(FormButtons.lightGrayImage, for: .normal)
      okButton.setBackgroundImage(FormButtons.primaryImage, for: .normal)
    }
    
    cancelButton.addTarget(self, action: #selector(onCancelButtonPressed), for: .touchUpInside)
    okButton.addTarget(self, action: #selector(onOkButtonPressed), for: .touchUpInside)
  }
  
  @IBAction func onCancelButtonPressed(_ sender:AnyObject){
   self.onCancelHandler?()
  }
  
  @IBAction func onOkButtonPressed(_ sender:AnyObject){
   self.onOkHandler?()
  }
  
  
  
  
  open func onCancel(_ handler:OnCancelHandler?) -> Self{
    self.onCancelHandler = handler
    return self
  }
  
  open func onOk(_ handler:OnOkHandler?) -> Self{
    self.onOkHandler = handler
    return self
  }
}

