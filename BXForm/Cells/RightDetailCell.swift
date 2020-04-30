//
//  RightDetailCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/24.
//
//

import Foundation
import BXModel

public final class RightDetailCell:StaticTableViewCell{
  public convenience init() {
    self.init(style: .value1, reuseIdentifier: "rightDetailCell")
  }
  
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
    public func commonInit(){
      accessoryType = .disclosureIndicator
      textLabel?.textColor = FormColors.primaryTextColor
  }
}
