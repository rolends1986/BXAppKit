//
//  VerticalLabelTextCell.swift
//  BXForm
//
//  Created by Haizhen Lee on 09/10/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//LabelTextCell:stc

public final class VerticalLabelTextCell : StaticTableViewCell, LeadingLabelRow, TextFieldCellAware{


  public  let labelLabel = UILabel(frame:.zero)
  public let inputTextField = UITextField(frame:.zero)

  public var textField:UITextField{
    return inputTextField
  }

  public convenience init() {
    self.init(style: .default, reuseIdentifier: "VerticalLabelTextCell")
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

   public var labelWidth: CGFloat = -1

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

  public  var paddingLeftConstraint:NSLayoutConstraint?
  public var labelWidthConstraint:NSLayoutConstraint? = nil
  fileprivate var paddingRightConstraint:NSLayoutConstraint?

  func installConstaints(){
    labelLabel.pa_top.eq(8).install()
    paddingLeftConstraint = labelLabel.pa_leadingMargin.eq(paddingLeft).install()
    inputTextField.pa_leading.eqTo(labelLabel).install()
    inputTextField.pa_below(labelLabel, offset: 4).install()
    inputTextField.pa_height.gte(32).install()
    paddingRightConstraint = inputTextField.pa_trailingMargin.eq(paddingRight).install()
    inputTextField.pa_bottom.eq(8).install()

  }

  func setupAttrs(){
    setupLeadingLabel()
    labelLabel.textAlignment = .left
    inputTextField.textAlignment = .left

  }




}
