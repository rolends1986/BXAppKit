//
//  StaticTableViewAdapter.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


open class SimpleStaticTableViewAdapter<T:UITableViewCell>:SimpleStaticTableViewDataSource<T>,UITableViewDelegate{
    open var referenceSectionHeaderHeight:CGFloat = 15
    open var referenceSectionFooterHeight:CGFloat = 15
    open var sectionHeaderView:UIView?
    open var sectionFooterView:UIView?
    open fileprivate(set) weak var tableView:UITableView?
    
    open var sectionHeaderHeight:CGFloat{
        return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
    }
    
    open var sectionFooterHeight:CGFloat{
        return sectionFooterView == nil ? 0:referenceSectionFooterHeight
    }
    
    open var didSelectCell:((T,IndexPath) -> Void)?
    
    
    open func bind(to tableView:UITableView){
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK:UITableViewDelegate
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
      let cell = staticCell(at:indexPath)
      if let stc = cell as? StaticTableViewCell{
          return stc.staticHeight
      }else{
          return tableView.rowHeight
      }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = staticCell(at: indexPath)
        self.didSelectCell?(cell,indexPath)
        cell.setSelected(false, animated: true)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return sectionHeaderHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return sectionFooterHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
        return sectionHeaderView
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
        return sectionFooterView
    }
    
    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return (staticCell(at: indexPath) as? StaticTableViewCell)?.shouldHighlight ?? true
    }
    
}
