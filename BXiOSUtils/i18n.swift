//
//  i18n.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 22/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

public func i18n(_ key:String,comment:String = "") -> String {
  let value = NSLocalizedString(key, comment: comment)
  return value.isEmpty ? key:value
}


public func str(_ format:String,_ arguments:CVarArg...) -> String{
  return String(format: format, arguments: arguments)
}
