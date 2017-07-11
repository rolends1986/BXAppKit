//
//  RadioGroup.swift
//
//  Created by Haizhen Lee on 15/12/5.
//

import UIKit
import SwiftyJSON
import BXModel

public final class RadioGroup<T:RadioOption> : UIView{
  public let radioGroup = UIStackView(frame: .zero)

  private var optionButtonMap:[T:RadioButton] = [:]

  public var configureRadioButton: ((RadioButton) -> Void)?
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public func update(options:[T]){
    radioGroup.removeAllArrangedSubview()
    for option in options{
      let button = RadioButton(frame: .zero)
      button.setTitle(option.title, for: .normal)
      button.setTitleColor(FormColors.primaryTextColor, for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
      configureRadioButton?(button)
      radioGroup.addArrangedSubview(button)
      optionButtonMap[option] = button

      button.addTarget(self, action: #selector(onRadioButtonPressed(sender:)), for: .touchUpInside)
    }
    if let first = options.first{
        select(option: first, triggerCallback: false)
    }
  }

  func onRadioButtonPressed(sender:RadioButton){
    var currentOption:T?
    for (option,button) in optionButtonMap{
      if button == sender{
        currentOption = option
        break
      }
    }

    if let selectedOption = currentOption{
      if selectedOption != previousSelectedOption{
        select(option: selectedOption, triggerCallback: true)
      }
    }
    previousSelectedOption = currentOption
  }


  public var onSelectedOptionChanged:((T) -> Void)?

  private var previousSelectedOption:T?
  
  public var selectedOption:T?{
    return previousSelectedOption
  }
  
  public func select(option:T, triggerCallback:Bool = false){
    for button in optionButtonMap.values{
      button.isOn = false
    }
    optionButtonMap[option]?.isOn = true
    if triggerCallback{
      onSelectedOptionChanged?(option)
    }
    previousSelectedOption = option
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    addSubview(radioGroup)
    radioGroup.translatesAutoresizingMaskIntoConstraints = false
    radioGroup.pac_edge(top:0, left: 0, bottom: 0, right: 0)
    backgroundColor = .clear

    radioGroup.axis = .horizontal
    radioGroup.distribution = .equalSpacing
    radioGroup.alignment = .center
    radioGroup.spacing = 8
  }
  

}
