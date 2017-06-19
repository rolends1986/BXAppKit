//
//  ComposeTableViewDataSource.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 19/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

public protocol ComposableTableViewAdapter:class, UITableViewDataSource,UITableViewDelegate{
  func bind(to tableView:UITableView)
}

open class ComposedTableViewAdapter:NSObject,UITableViewDataSource, UITableViewDelegate{
  open fileprivate(set) weak var tableView:UITableView?
  public private(set) var childAdapters:[ComposableTableViewAdapter] = []

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

  public func add(adapter: ComposableTableViewAdapter){
    childAdapters.append(adapter)
    if let tv = tableView{
      rebind(to: tv)
    }
    tableView?.reloadData()
  }

  public func update(adapters:[ComposableTableViewAdapter]){
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
    return childAdapters[section].tableView?(tableView,heightForHeaderInSection:section) ?? 0
  }

  open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return childAdapters[section].tableView?(tableView,heightForFooterInSection:section) ?? 0
  }

  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    let header = childAdapters[section].tableView?(tableView,viewForHeaderInSection:section)
    return header
  }

  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return childAdapters[section].tableView?(tableView,viewForFooterInSection:section)
  }

  // MARK: UITableViewDelegate
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     childAdapters[indexPath.section].tableView?(tableView,didSelectRowAt:indexPath)
  }

  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    childAdapters[indexPath.section].tableView?(tableView,willDisplay:cell, forRowAt:indexPath)
  }






}
