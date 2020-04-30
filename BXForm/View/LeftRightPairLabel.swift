//
//  LeftRightPairLabel.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 01/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

protocol LabelPair {
  var label1:UILabel { get  }
  var label2:UILabel { get  }
  
}


open class LeftRightPairLabel : UIControl {
    public let leftLabel = UILabel(frame:CGRect.zero)
    public let rightLabel = UILabel(frame:CGRect.zero)


  open func bind(leftLabel:String, rightLabel:String=""){
    self.leftLabel.text = leftLabel
    self.rightLabel.text = rightLabel
  }


  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }


  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var allOutlets :[UIView]{
    return [leftLabel,rightLabel]
  }
  var allUILabelOutlets :[UILabel]{
    return [leftLabel,rightLabel]
  }

  func commonInit(){
    translatesAutoresizingMaskIntoConstraints = false
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()

  }

  open class override var requiresConstraintBasedLayout : Bool{
    return true
  }

  var innerSpaceConstraint:NSLayoutConstraint?

  open var leftRightSpace:CGFloat = 4{
    didSet{
      innerSpaceConstraint?.constant = leftRightSpace
      invalidateIntrinsicContentSize()
    }
  }

  func installConstaints(){
    leftLabel.pa_centerY.install()
    leftLabel.pa_leading.eq(0).install()

    innerSpaceConstraint =  rightLabel.pa_after(leftLabel,offset:leftRightSpace).install()
    rightLabel.pa_centerY.install()
    rightLabel.pa_trailing.eq(0).install()

  }

  open override var intrinsicContentSize : CGSize {
    let topSize = leftLabel.intrinsicContentSize
    let bottomSize = rightLabel.intrinsicContentSize
    let width = topSize.width + leftRightSpace + bottomSize.width
    let height = max(bottomSize.height,topSize.height)
    return CGSize(width: width, height: height)
  }

  func setupAttrs(){
    leftLabel.textColor = FormColors.accentColor
    leftLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)

    rightLabel.textColor = FormColors.primaryTextColor
    rightLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)

  }
}
