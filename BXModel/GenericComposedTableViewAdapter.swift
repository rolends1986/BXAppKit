//
//  GenericComposedTableViewAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 05/07/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


open class GenericComposedTableViewAdapter<T>:BaseDataSource<T>,UITableViewDataSource, UITableViewDelegate{
  open fileprivate(set) weak var tableView:UITableView?
  public private(set) var childAdapters:[BaseSimpleTableViewAdapter<T>] = []

  public var onItemsDidChanged:(([T]) -> Void)?

  open override func onItemsChanged() {
    self.onItemsDidChanged?(items)
  }

  
  open func bind(to tableView:UITableView){
    self.tableView = tableView
    rebind(to: tableView)
  }

  private func rebind(to tableView:UITableView){
    for ds in childAdapters{
      ds.bind(to: tableView)
    }
    tableView.dataSource = self
    tableView.delegate = self
  }

  public func add(adapter: BaseSimpleTableViewAdapter<T>){
    childAdapters.append(adapter)
    if let tv = tableView{
      rebind(to: tv)
    }
    tableView?.reloadData()
  }

  public func update(adapters:[BaseSimpleTableViewAdapter<T>]){
    childAdapters = adapters
    if let tv = tableView{
      rebind(to: tv)
    }
    tableView?.reloadData()
  }


  // MARK: UITableViewDataSource

  open func numberOfSections(in tableView: UITableView) -> Int {
    return childAdapters.count
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return childAdapters[section].tableView(tableView,numberOfRowsInSection:section)
  }

  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return childAdapters[indexPath.section].tableView(tableView,cellForRowAt:indexPath)
  }


  // MARK: UITableViewDataSource SectionHeaderFooter
  open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    return childAdapters[section].tableView(tableView,heightForHeaderInSection:section)
  }

  open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return childAdapters[section].tableView(tableView,heightForFooterInSection:section)
  }

  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    let header = childAdapters[section].tableView(tableView,viewForHeaderInSection:section)
    return header
  }

  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return childAdapters[section].tableView(tableView,viewForFooterInSection:section)
  }

  // MARK: UITableViewDelegate
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    childAdapters[indexPath.section].tableView(tableView,didSelectRowAt:indexPath)
  }

//  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    childAdapters[indexPath.section].tableView(tableView,willDisplay:cell, forRowAt:indexPath)
//  }
//  

  
  
  
  
}
