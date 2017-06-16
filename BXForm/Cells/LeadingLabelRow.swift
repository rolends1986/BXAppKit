//
//  LeadingLabelRow
//  BXAppKit
//
//  Created by Haizhen Lee on 16/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
// 为所以 Leading  Label 抽象出一个共用的协议类

public protocol LeadingLabelRow:class{
  // 后面考虑修改名称为 leadingLabel
  var labelLabel:UILabel { get }
  var labelWidth:CGFloat { get set }
}

public extension LeadingLabelRow{
  public var leadingLabel:UILabel{ return labelLabel }

  public var label:String?{
    get{
      return labelLabel.text
    }set{
      labelLabel.text = newValue
    }
  }

  public func setupLeadingLabel(){
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    labelLabel.textAlignment = .right
  }

}
