//
//  RightImageCell.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 13/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit
import BXModel
import BXiOSUtils

final public class RightImageCell : StaticTableViewCell,LeadingLabelRow{
  public let labelLabel = UILabel(frame:.zero)
  public let rightImageView = OvalImageView()


  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AvatarCellCell")
  }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    return [labelLabel,rightImageView]
  }


  func commonInit(){
    staticHeight = 65
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


  public var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }



  public var paddingLeftConstraint:NSLayoutConstraint?
  public var labelWidthConstraint:NSLayoutConstraint?

  func installConstaints(){
    installLeadingLabelConstraints()
    rightImageView.pa_centerY.install()
    rightImageView.pa_trailingMargin.eq(4).install()

  }

  func setupAttrs(){
    setupLeadingLabel()
    rightImageView.contentMode = .scaleAspectFill
    accessoryType = .disclosureIndicator
    rightImageView.clipsToBounds = true

  }


}
