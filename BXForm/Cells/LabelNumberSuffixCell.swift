//
//  LabelNumberSuffixCell.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 11/08/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//LabelTextCell:stc

final public class LabelNumberSuffixCell : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let inputTextField = UITextField(frame:.zero)
  public let suffixLabel = UILabel(frame: .zero)

  public var textField:UITextField{
    return inputTextField
  }

  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AbelTextCellCell")
  }

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }



  public func bind(label:String,text:String){
    labelLabel.text  = label
    inputTextField.text  = text
  }

  public func bind(label:String,placeholder:String){
    labelLabel.text  = label
    inputTextField.placeholder  = placeholder
  }

  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var allOutlets :[UIView]{
    return [labelLabel,inputTextField,suffixLabel]
  }
  var allUILabelOutlets :[UILabel]{
    return [labelLabel]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [inputTextField]
  }

  func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()

  }

  public var paddingLeft:CGFloat = FormMetrics.cellPaddingLeft{
    didSet{
      paddingLeftConstraint?.constant = paddingLeft
    }
  }

  public var paddingRight:CGFloat = FormMetrics.cellPaddingRight{
    didSet{
      paddingRightConstraint?.constant = paddingRight
    }
  }

  public var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }

  public var paddingLeftConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  public  var labelWidthConstraint:NSLayoutConstraint?

  func installConstaints(){
    installLeadingLabelConstraints()

    suffixLabel.pa_centerY.install()
    paddingRightConstraint = suffixLabel.pa_trailingMargin.eq(paddingRight).install()
    

    inputTextField.pa_centerY.install()
    inputTextField.pa_height.eq(32).install()
    inputTextField.pa_before(suffixLabel,offset:4).install()
    inputTextField.pa_width.eq(52).withHighPriority.install()
    

  }

  func setupAttrs(){
    setupLeadingLabel()

    inputTextField.textAlignment = .center
    inputTextField.keyboardType = .numberPad

    suffixLabel.textColor = FormColors.primaryTextColor
    suffixLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)

  }



  public var inputText:String{
    get{ return inputTextField.text?.trimmed() ?? "" }
    set{ inputTextField.text = newValue }
  }

  public var placeholder:String?{
    get{ return inputTextField.placeholder }
    set{
      if let str = newValue{
        inputTextField.attributedPlaceholder = NSAttributedString(string: str,attributes:[
          NSAttributedStringKey.font: UIFont.systemFont(ofSize: FormMetrics.secondaryFontSize),
          NSAttributedStringKey.foregroundColor: FormColors.hintTextColor
          ])
      }else{
        inputTextField.attributedPlaceholder = nil
      }
    }
  }
}
