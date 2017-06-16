//
//  SwitchButton.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 16/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

final public class SwitchButton: UIButton{

  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func commonInit(){
    addTarget(self, action: #selector(_onTap), for: .touchUpInside)
  }

  public var onSwitchStateChanged: ((Bool) -> Void)?

  func _onTap(){
    isSelected = !isSelected
    onSwitchStateChanged?(isSelected)
  }

  open dynamic var onImage:UIImage?{
    get{ return image(for: .selected) }
    set{
      setImage(newValue, for: .selected)
    }
  }

  open dynamic var offImage:UIImage?{
    get{ return image(for: .normal) }
    set{
      setImage(newValue, for: .normal)
    }
  }

  open var isOn:Bool{
    get{ return isSelected }
    set{
      isSelected = newValue
      onSwitchStateChanged?(newValue)
    }
  }
}
