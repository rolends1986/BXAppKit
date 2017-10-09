//
//  VerticalLabelDetailCell.swift
//  BXForm
//
//  Created by Haizhen Lee on 09/10/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//LabelTextCell:stc

public final class VerticalLabelDetailCell : StaticTableViewCell, LeadingLabelRow{


  public  let labelLabel = UILabel(frame:.zero)
  public let detailLabel = UILabel(frame:.zero)

  public convenience init() {
    self.init(style: .default, reuseIdentifier: "VerticalLabelDetailCell")
  }

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }


  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var allOutlets :[UIView]{
    return [labelLabel,detailLabel]
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

  fileprivate var paddingLeftConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?

  func installConstaints(){
    labelLabel.pa_top.eq(8).install()
    paddingLeftConstraint = labelLabel.pa_leadingMargin.eq(paddingLeft).install()
    detailLabel.pa_leading.eqTo(labelLabel).install()
    detailLabel.pa_below(labelLabel, offset: 4).install()
    detailLabel.pa_height.gte(32).install()
    paddingRightConstraint = detailLabel.pa_trailingMargin.eq(paddingRight).install()
    detailLabel.pa_bottom.eq(8).install()

  }

  func setupAttrs(){
    setupLeadingLabel()
    labelLabel.textAlignment = .left
    detailLabel.textAlignment = .left

    detailLabel.textColor = FormColors.secondaryTextColor
    detailLabel.font = UIFont.systemFont(ofSize: FormMetrics.secondaryFontSize)

  }




}
