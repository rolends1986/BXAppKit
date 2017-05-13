//
//  SwitchCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/24.
//
//

import UIKit
import PinAuto
import BXModel

// -SwitchCell:tc
// toggle[x,r15]:sw

open class SwitchCell : StaticTableViewCell,BXBindable{
  open let toggleSwitch = UISwitch(frame:.zero)
  public let tipLabel = UILabel(frame: .zero)
  public var showTip:Bool = false{
    didSet{
      tipLabel.isHidden = !showTip
    }
  }
  public var tipOn:String?
  public var tipOff:String?
  
  public convenience init() {
    self.init(style: .value1, reuseIdentifier: "SwitchCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  open func bind(_ item:Bool){
    toggleSwitch.isOn = item
    contentView.bringSubview(toFront: toggleSwitch)
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [toggleSwitch, tipLabel]
  }
  var allUISwitchOutlets :[UISwitch]{
    return [toggleSwitch]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    staticHeight = 44
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()

    toggleSwitch.addTarget(self, action: #selector(onSwitchStatusChanged), for: .valueChanged)

  }
  
  func installConstaints(){
    toggleSwitch.pa_centerY.install()
    toggleSwitch.pa_trailingMargin.eq(FormMetrics.cellPaddingRight).install()

    tipLabel.pa_before(toggleSwitch, offset: 4).install()
    tipLabel.pa_centerY.install()
    
  }
  
  func setupAttrs(){
    backgroundColor = .white
    textLabel?.font = UIFont.systemFont(ofSize: 15)
    textLabel?.textColor = FormColors.primaryTextColor

    tipLabel.font = UIFont.systemFont(ofSize: 13)
    tipLabel.textColor = FormColors.hintTextColor

  }

  func onSwitchStatusChanged(){
    if showTip{
      tipLabel.text = isOn ? tipOn:tipOff
    }
  }
  
  
  
  open var isOn:Bool{
    get{ return toggleSwitch.isOn }
    set{
      toggleSwitch.isOn = newValue
      onSwitchStatusChanged()
    }
  }
}
