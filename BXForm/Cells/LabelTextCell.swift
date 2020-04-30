//
//  LabelTextCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/24.
//
//

import Foundation

public extension UITextField{
  public func setPlaceholderWithFormStyle(placeholder:String)  {
    attributedPlaceholder = NSAttributedString(string: placeholder,attributes:[
         .font: UIFont.systemFont(ofSize: 13),
      .foregroundColor: FormColors.hintTextColor
      ])
  }
}

public protocol TextFieldCellAware:class{
  var inputTextField:UITextField { get }
}

public extension TextFieldCellAware{
  public var inputText:String{
    get{ return inputTextField.text?.trimmed() ?? "" }
    set{ inputTextField.text = newValue }
  }

  public var placeholder:String?{
    get{ return inputTextField.placeholder }
    set{
      if let str = newValue{
        inputTextField.setPlaceholderWithFormStyle(placeholder: str)
      }else{
        inputTextField.attributedPlaceholder = nil
      }
    }
  }
}



// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//LabelTextCell:stc

final public class LabelTextCell : StaticTableViewCell, LeadingLabelRow, TextFieldCellAware{
  public let labelLabel = UILabel(frame:.zero)
  public let inputTextField = UITextField(frame:.zero)

  public var textField:UITextField{
    return inputTextField
  }
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AbelTextCellCell")
  }
  
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    return [labelLabel,inputTextField]
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
  public var labelWidthConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    installLeadingLabelConstraints()
    
    inputTextField.pa_centerY.install()
    inputTextField.pa_height.eq(32).install()
    paddingRightConstraint = inputTextField.pa_trailingMargin.eq(paddingRight).install()
    inputTextField.pa_after(labelLabel,offset:8).install()
    
  }
  
  func setupAttrs(){
    setupLeadingLabel()
    
    inputTextField.textAlignment = .right
    
  }
  



}

