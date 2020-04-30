//
//  LoginButtonCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/23.
//
//

import UIKit
import BXModel
import BXiOSUtils
import PinAuto

//-LoginButtonCell:stc
//login[t18,l10,r10,h50](cw,f18,text=登录):b
//reg[at10@login,bl14@login](f15,ctt,text=快速注册):b
//reset[bf10@login,y@reg](f15,ctt,text=忘记密码):b

public final class LoginButtonCell : StaticTableViewCell{
  public let loginButton = UIButton(type:.system)
  public let regButton = UIButton(type:.system)
  public let resetButton = UIButton(type:.system)
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LoginButtonCellCell")
  }
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
    public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [loginButton,regButton,resetButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [loginButton,regButton,resetButton]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
    public func commonInit(){
    staticHeight = 120
    frame = CGRect(x: 0, y: 0, width: 320, height: staticHeight)
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    loginButton.pa_height.eq(50).install()
    loginButton.pa_trailingMargin.eq(FormMetrics.cellPaddingLeft).install()
    loginButton.pa_top.eq(5).install()
    loginButton.pa_leadingMargin.eq(FormMetrics.cellPaddingRight).install()
    regButton.pa_below(loginButton,offset:14).install()
    regButton.pa_leading.to(loginButton).offset(10).install()
    resetButton.pa_centerY.to(regButton).install()
    resetButton.pa_trailing.to(loginButton).offset(10).install()
  }
  
    public func setupAttrs(){
    loginButton.setTitle(i18n("登录"),for: .normal)
    loginButton.setTitleColor(UIColor.white,for: .normal)
    loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    regButton.setTitleColor(FormColors.tertiaryTextColor,for: .normal)
    regButton.setTitle(i18n("快速注册"),for: .normal)
    regButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    resetButton.setTitleColor(FormColors.tertiaryTextColor,for: .normal)
    resetButton.setTitle(i18n("忘记密码"),for: .normal)
    resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
  }
}
