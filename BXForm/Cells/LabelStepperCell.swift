//
//  LabelStepperCell.swift
//  Pods
//
//  Created by Haizhen Lee on 11/26/16.
//
//


import Foundation
import UIKit
import BXModel
import BXiOSUtils


public final class LabelStepperCell : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let stepper = StepperView()
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelStepperCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open var allOutlets :[UIView]{
    return [labelLabel,stepper]
  }
  
  open func commonInit(){
    staticHeight = 68
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open var paddingLeft:CGFloat = FormMetrics.cellPaddingLeft{
    didSet{
      paddingLeftConstraint?.constant = paddingLeft
    }
  }
  
  open var paddingRight:CGFloat = FormMetrics.cellPaddingRight{
    didSet{
      paddingRightConstraint?.constant = paddingRight
    }
  }
  
  open var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }
  
  public  var paddingLeftConstraint:NSLayoutConstraint?
  public  var labelWidthConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  
  
  
  open func installConstaints(){
    installLeadingLabelConstraints()
    stepper.pa_centerY.install()
    paddingRightConstraint =  stepper.pa_trailingMargin.eq(paddingRight).install()
  }
  
  open func setupAttrs(){
    setupLeadingLabel()
    accessoryType = .none
    
  }
  

  
}
