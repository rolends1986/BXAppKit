//
//  LabelTextViewCell.swift
//
//  Created by Haizhen Lee on 16/1/26.
//

import Foundation

import UIKit
import BXModel
import BXiOSUtils

//-LabelTextViewCell:stc
//label[w85,t15](f17,cpt)
//_[at4@label,y,r15](f15,cst):tv

public enum LeadingLabelPosition{
  case top
  case middle
}

public final class LabelTextViewCell : StaticTableViewCell, LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let textView = ExpandableTextView(frame:.zero)
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LabelTextViewCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open var allOutlets :[UIView]{
    return [labelLabel,textView]
  }
  var allUILabelOutlets :[UILabel]{
    return [labelLabel]
  }
  var allUITextViewOutlets :[UITextView]{
    return [textView]
  }
  
  open func commonInit(){
    staticHeight = 80
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
  
  public var paddingLeftConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  public  var labelWidthConstraint:NSLayoutConstraint?

  public var labelCenterYConstraint:NSLayoutConstraint?
  public var labelTopConstraint:NSLayoutConstraint?

  public var leadingLabelPosition = LeadingLabelPosition.middle{
    didSet{
      switch leadingLabelPosition {
      case .top:
        labelCenterYConstraint?.isActive = false
        labelTopConstraint?.isActive = true
      case .middle:
        labelCenterYConstraint?.isActive = true
        labelTopConstraint?.isActive = false
      }
    }
  }
  
  open func installConstaints(){
    labelCenterYConstraint = labelLabel.pa_centerY.install()
    labelTopConstraint = labelLabel.pa_top.eq(8).install()
    labelTopConstraint?.isActive = false
    
    paddingLeftConstraint = labelLabel.pa_leadingMargin.eq(paddingLeft).install()
    labelWidthConstraint =  labelLabel.pa_width.eq(labelWidth).install()
    textView.pa_top.eq(8).install()
    paddingRightConstraint =  textView.pa_trailingMargin.eq(paddingRight).install()
    textView.pa_after(labelLabel,offset:8).install()
    textView.pa_bottom.eq(10).install()
  }
  
  open func setupAttrs(){
    setupLeadingLabel()
    textView.textColor = FormColors.secondaryTextColor
    textView.font = UIFont.systemFont(ofSize: FormMetrics.secondaryFontSize)
    textView.setTextPlaceholderFont(textView.font!)
    textView.setTextPlaceholderColor(FormColors.hintTextColor)
    
    textView.textAlignment = .left
   
    shouldHighlight = false
    
  }

  public var inputText:String{
    get{ return textView.text }
    set{ textView.text = newValue }
  }

}
