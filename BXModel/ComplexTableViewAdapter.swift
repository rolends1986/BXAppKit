//
//  ComplexTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/3.
//
//

import Foundation
import UIKit

public enum TableDecorView{
  case header(UIView,CGFloat)
}

/// ComplexTableViewAdapter 分为两个 Section 第一个 Section 为 StaticCell List 第二个为 Dynamic Cell List
@available(*,deprecated,  message: "will be removed at next version")
open class ComplexTableViewAdapter<T,V:StaticTableViewCell>:SimpleGenericTableViewAdapter<T,V> where V:BXBindable {
  var cells:[UITableViewCell] = []
  public init(
    tableView:UITableView? = nil,
    items:[T] = [],
    cells:[UITableViewCell] = []){
      super.init(tableView: tableView, items: items)
    self.cells = cells
  }
  
  open func cellAtIndexPath(_ indexPath:IndexPath) -> UITableViewCell{
    return self.cells[indexPath.row]
  }
  
  open override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    return section == 0 ? nil:  sectionHeaderView
  }
  
  open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return section == 0 ? nil: sectionFooterView
  }
  

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0{
      return cells.count
    }else{
      return super.tableView(tableView, numberOfRowsInSection: section)
    }
  }
  
  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    if indexPath.section == 0{
      return cellAtIndexPath(indexPath)
    }else{
      return super.cellForRowAtIndexPath(indexPath)
    }
  }
  
  open override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.section == 0{
        // Do nothing
    }else{
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
  }
  
  open func append(cell:UITableViewCell){
    self.cells.append(cell)
    tableView?.reloadData()
  }
  
  open func append(cells:[UITableViewCell]){
    self.cells.append(contentsOf: cells)
    tableView?.reloadData()
  }
  
}
