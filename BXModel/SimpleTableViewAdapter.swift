//
//  SimpleTableViewAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 21/04/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit

open class SimpleTableViewAdapter<T:UITableViewCell>: SimpleTableViewDataSource<T.ModelType>,UITableViewDelegate where T:BXBindable {

  open fileprivate(set) weak var tableView:UITableView?
  open var didSelectedItem: DidSelectedItemBlock?
  open var preBindCellBlock:( (T, T.ModelType, IndexPath) -> Void )?
  open var postBindCellBlock:( (T,T.ModelType, IndexPath) -> Void )?
  public typealias WillDisplayCellBlock = ( (T,T.ModelType,IndexPath) -> Void )
  open var willDisplayCellBlock: WillDisplayCellBlock?

  open var allowSelection = false

  open var referenceSectionHeaderHeight:CGFloat = 15
  open var referenceSectionFooterHeight:CGFloat = 15
  open var sectionHeaderView:UIView?
  open var sectionFooterView:UIView?
  open var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }

  open var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }

  public init(tableView:UITableView? = nil,items:[T.ModelType] = []){
    super.init(items: items)
    if let tableView = tableView{
      bindTo(tableView)
    }
  }

  open func bindTo(_ tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
    self.reuseIdentifier = simpleClassName(T.self)+"_cell"
    if T.hasNib{
      tableView.register(T.nib(), forCellReuseIdentifier: reuseIdentifier)
    }else{
      tableView.register(T.self, forCellReuseIdentifier: reuseIdentifier)
    }
  }

  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectedItem?(item(at:indexPath),indexPath)
    if !allowSelection{
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }


  open override func configureTableViewCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
    configure(cell: cell as! T, atIndexPath: indexPath)
  }


  open func preConfigure(cell:T,model:T.ModelType,indexPath:IndexPath){
    preBindCellBlock?(cell,model,indexPath)
  }

  open func configure(cell:T,atIndexPath indexPath:IndexPath){
    let model = item(at:indexPath)
    preConfigure(cell: cell, model: model,indexPath: indexPath)
    cell.bind(model)
    postConfigure(cell: cell, model: model, indexPath: indexPath)
  }

  open func postConfigure(cell:T,model:T.ModelType,indexPath:IndexPath){
    postBindCellBlock?(cell,model, indexPath)
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

  //MARK: UITableViewDelegate
  open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let model = item(at:indexPath)
    if let subCell = cell as? T{
      self.willDisplayCellBlock?(subCell,model,indexPath)
    }
  }

}
