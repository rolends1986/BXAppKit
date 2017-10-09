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

final public class RightImageCell : StaticTableViewCell{
  public let labelLabel = UILabel(frame:.zero)
  public let rightImageView = OvalImageView()


  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AvatarCellCell")
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

  func installConstaints(){
    labelLabel.pa_leadingMargin.eq(FormMetrics.cellPaddingLeft).install()
    labelLabel.pa_centerY.install()
    rightImageView.pa_centerY.install()
    rightImageView.pa_trailingMargin.eq(4).install()

  }

  func setupAttrs(){
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFont(ofSize: 15)
    rightImageView.contentMode = .scaleAspectFill
    accessoryType = .disclosureIndicator
    rightImageView.clipsToBounds = true

  }


}
