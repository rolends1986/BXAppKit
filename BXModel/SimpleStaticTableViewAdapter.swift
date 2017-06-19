//
//  StaticTableViewAdapter.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


open class SimpleStaticTableViewAdapter<T:UITableViewCell>:BaseSimpleStaticTableViewAdapter<T>{

    
    open var didSelectCell:((T,IndexPath) -> Void)?
    
    

    // MARK:UITableViewDelegate
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
      let cell = staticCell(at:indexPath)
      if let stc = cell as? StaticTableViewCell{
          return stc.staticHeight
      }else{
          return super.tableView(tableView, heightForRowAt: indexPath)
      }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
