//
//  New_StaticTableViewDataSource.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 21/04/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit

open class BaseSimpleStaticTableViewAdapter<T:UITableViewCell>:BaseSimpleTableViewAdapter<T>{
  open var section = 0

  public init(cells:[T] = []){
    super.init(items: cells)
  }

  public var staticCells:[T]{
    return items
  }

  open func staticCell(at indexPath:IndexPath) -> T{
    return self.staticCells[indexPath.row]
  }

  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = item(at:indexPath)
    self.configureCellBlock?(cell,indexPath)
    return cell
  }

  open func append(_ cell:T){
    if !staticCells.contains(cell){
      super.appendItems([cell])
    }
  }

  open func append(cells:[T]){
    for cell in cells{
      append(cell)
    }
  }


}
