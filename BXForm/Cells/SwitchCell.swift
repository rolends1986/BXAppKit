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

public final class SwitchCell : StaticTableViewCell,BXBindable{
  public let switchButton = UIButton(type: .custom)
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
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  public func bind(_ item:Bool,indexPath: IndexPath){
    switchButton.isSelected = item
    contentView.bringSubviewToFront(switchButton)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [switchButton, tipLabel]
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

    switchButton.addTarget(self, action: #selector(_onTap), for: .touchUpInside)

  }

  public var onSwitchStateChanged: ((Bool) -> Void)?

  @objc func _onTap(){
    switchButton.isSelected = !switchButton.isSelected
    onSwitchStatusChanged()
    onSwitchStateChanged?(switchButton.isSelected)
  }
  
  func installConstaints(){
    switchButton.pa_centerY.install()
    switchButton.pa_trailingMargin.eq(FormMetrics.cellPaddingRight).install()

    tipLabel.pa_before(switchButton, offset: 4).install()
    tipLabel.pa_centerY.install()
    
  }
  
  func setupAttrs(){
    backgroundColor = .white
    textLabel?.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    textLabel?.textColor = FormColors.primaryTextColor
    textLabel?.backgroundColor = nil

    tipLabel.font = UIFont.systemFont(ofSize: FormMetrics.secondaryFontSize)
    tipLabel.textColor = FormColors.hintTextColor

  }

  func onSwitchStatusChanged(){
    if showTip{
      tipLabel.text = isOn ? tipOn:tipOff
    }
  }
  

  @objc public dynamic var onImage:UIImage?{
    get{ return switchButton.image(for: .selected) }
    set{
      switchButton.setImage(newValue, for: .selected)
    }
  }
  
  @objc public dynamic var offImage:UIImage?{
    get{ return switchButton.image(for: .normal) }
    set{
      switchButton.setImage(newValue, for: .normal)
    }
  }
  
    public var isOn:Bool{
    get{ return switchButton.isSelected }
    set{
      switchButton.isSelected = newValue
      onSwitchStatusChanged()
    }
  }
}
