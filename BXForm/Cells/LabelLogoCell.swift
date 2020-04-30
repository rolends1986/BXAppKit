//
//  LabelLogoCell.swift
//  Pods
//
//
//

import Foundation
import UIKit
import BXModel
import BXiOSUtils


public final class LabelLogoCell : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let logoImageView = OvalImageView()
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelSpanCell")
  }
  
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
 public  override   func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public var allOutlets :[UIView]{
    return [labelLabel,logoImageView]
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
  
  public var logoWidth:CGFloat = 52{
    didSet{
      logoWidthConstraint?.constant = logoWidth
      staticHeight = logoWidth + 16
    }
  }
  
  public var paddingLeftConstraint:NSLayoutConstraint?
   public var labelWidthConstraint:NSLayoutConstraint?
    fileprivate var paddingRightConstraint:NSLayoutConstraint?
    fileprivate var logoWidthConstraint:NSLayoutConstraint?
  
  
  
  public func installConstaints(){
    installLeadingLabelConstraints()
    logoImageView.pa_aspectRatio(1.0).install()
    logoWidthConstraint =  logoImageView.pa_width.eq(logoWidth).install()
    paddingRightConstraint =  logoImageView.pa_trailingMargin.eq(paddingRight).install()
  }
  
  public func setupAttrs(){
    setupLeadingLabel()
    accessoryType = .disclosureIndicator
    
  }
  

  
}
