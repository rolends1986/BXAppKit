//
//  FooterNoteCell.swift
//  BXForm
//
//  Created by Haizhen Lee on 15/11/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit
import BXModel

public class FooterNoteCell:StaticTableViewCell{
  public let noteLabel = UILabel(frame: .zero)

  public init(top:CGFloat = 4,leadingMargin:CGFloat = 7){
    super.init(style: .default, reuseIdentifier: nil)
    staticHeight = 28
    contentView.addSubview(noteLabel)
    noteLabel.translatesAutoresizingMaskIntoConstraints = false
    noteLabel.pa_leadingMargin.eq(leadingMargin).install()
    noteLabel.pa_top.eq(top).install()

    noteLabel.textColor = FormColors.hintTextColor
    noteLabel.font = UIFont.systemFont(ofSize: FormMetrics.tertiaryFontSize, weight: .light)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
