//
//  CompoundButton.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 20/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

open class CompoundButton:IconButton{

  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  public func commonInit(){
    contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    addTarget(self, action: #selector(_onTap), for: .touchUpInside)
  }


  @objc func _onTap(){
    isSelected = !isSelected
    onSelectStateChanged?(isSelected)
  }

  public var onSelectStateChanged: ((Bool) -> Void)?

  public var triggerCallbackOnSet = false

  open var isOn:Bool{
    get{ return isSelected }
    set{
      isSelected = newValue
      if triggerCallbackOnSet{
        onSelectStateChanged?(newValue)
      }
    }
  }

  public var isChecked:Bool{
    get{ return isSelected }
    set{
      isOn = newValue
    }
  }

  open func toggle(){
    isSelected = !isSelected
    if triggerCallbackOnSet{
      onSelectStateChanged?(isSelected)
    }
  }

}
