//
//  StaticTableViewAdapter.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


open class SimpleStaticTableViewAdapter<T:UITableViewCell>:BaseSimpleTableViewAdapter<T>{

  open var configureCellBlock:((UITableViewCell,IndexPath) -> Void)?
  open var didSelectCell:((T,IndexPath) -> Void)?

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
    self.preConfigureCellBlock?(cell,indexPath)
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
    

    // MARK:UITableViewDelegate
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
      let cell = staticCell(at:indexPath)
      if let stc = cell as? StaticTableViewCell{
          return stc.staticHeight
      }else{
          return super.tableView(tableView, heightForRowAt: indexPath)
      }
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = staticCell(at: indexPath)
        self.didSelectCell?(cell,indexPath)
        cell.setSelected(false, animated: true)
    }
    

    
    open override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
      if let stc = staticCell(at: indexPath) as? StaticTableViewCell{
        return stc.shouldHighlight
      }else{
        return super.tableView(tableView, shouldHighlightRowAt: indexPath)
      }
    }
    
}

public typealias StaticTableViewAdapter = SimpleStaticTableViewAdapter<UITableViewCell>
