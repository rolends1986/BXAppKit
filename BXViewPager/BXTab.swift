//
//  BXTab.swift
//  BXViewPager
//
//  Created by Haizhen Lee on 15/11/18.
//  Copyright © 2015年 CocoaPods. All rights reserved.
//

import UIKit

/// BXTabView 目标只支持对 text 和  badgeValue 两个字段值的处理.
open class BXTab{
  public static let INVALID_POSITION = -1
  /// tab 名称
  open var text:String?
  /// tab 上的小圆点
  open var badgeValue:String?
  ///
  open var contentDesc:String?
  open var tag:AnyObject?
  /// 使用图标的 Tab
  open var icon:UIImage?
  
  open var position = BXTab.INVALID_POSITION
  
  public init(text:String?,icon:UIImage? = nil){
    self.text = text
    self.icon = icon
  }
}

extension BXTab:Hashable{
  public var hashValue: Int{
    if let text = text{
      return text.hashValue
    }else if let icon =  icon{
      return icon.hashValue
    }
    return position
  }

  public static func ==(lhs:BXTab, rhs:BXTab) -> Bool{
    return lhs.text == rhs.text && lhs.icon == rhs.icon && lhs.position == rhs.position
  }
}
