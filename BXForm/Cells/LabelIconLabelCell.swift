//
//  LabelIconLabelCell.swift
//  Pods
//
//  Created by Haizhen Lee on 11/26/16.
//
//


import Foundation
import UIKit
import BXModel
import BXiOSUtils

public   class LabelIconLabelCell : StaticTableViewCell,LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let iconLabel = IconLabel()
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelIconLabelCell")
  }
  
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
    override public func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
    public var allOutlets :[UIView]{
    return [labelLabel,iconLabel]
  }
  
    public func commonInit(){
    staticHeight = 68
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
  public var labelWidthConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  
  
  
    public func installConstaints(){
    installLeadingLabelConstraints()
    iconLabel.pa_centerY.install()
    paddingRightConstraint =  iconLabel.pa_trailingMargin.eq(paddingRight).install()
  }
  
    public func setupAttrs(){
    setupLeadingLabel()
    iconLabel.textColor = FormColors.primaryTextColor
    iconLabel.font = UIFont.systemFont(ofSize:FormMetrics.primaryFontSize)
    iconLabel.textLabel.textAlignment = .right
    accessoryType = .none
    
  }
  
  public var label:String?{
    get{
      return labelLabel.text
    }set{
      labelLabel.text = newValue
    }
  }
  
}
