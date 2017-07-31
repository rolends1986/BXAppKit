//
//  SimpleTableViewDataSource.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit


/// 基础公开 TableViewAdapter
/// Simple 在此 模块中,指的是针对 单一 Section 的意思.
/// 如果有多个 Section 的话,可以使用 ComposedTableViewAdapter 来组合使用
open class BaseSimpleTableViewAdapter<T>:BaseDataSource<T>,ComposableTableViewAdapter{
  open var cellClass: UITableViewCell.Type = UITableViewCell.self

  open var didSelectedItem: DidSelectedItemBlock?
  open var didDeselectedItem: DidDeselectedItemBlock?
  open var preConfigureCellBlock: ((UITableViewCell,IndexPath) -> Void)?

  /// 由于 Delegate 和 DataSource 可选协议众多,此包装不方便一一包装.
  /// 这个时候有需要的 可以通过 fallbackDelegate 和 fallbackDataSource
  /// 让需要的实现此类方法的在应用时实现,以免提供所需要实现接口
  /// 注意这是 fallback ,所以对于如 sectionHeader 之类的控制 
  /// 本包装类已经提供了,就不会再调用 fallbackDataSource 了.
  /// 暂时没有添加其实实现,需要的时候再加
  /// NOTE: 值得注意的是,在实际使用中,原来 didSelectRowAt 方法是在 BaseSimpleTableViewAdapter
  /// 中实现的,但是测试发现,如果在其子类实现的话,导致无法在 ComposedTableAdapter 中通过 ComposableTableViewAdapter 
  open var fallbackDelegate:UITableViewDelegate?
  open var fallbackDataSource:UITableViewDataSource?

  // MARK: Section Header Footer
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

  // MARK: 选择效果与高亮, 
  /// 默认为 false 点击效果之后 deselect
  open var allowSelection = false

  /// 是否允许有点击效果,禁止高亮会有禁止选择 Cell 的效果.
  open var shouldHilightRow: ((IndexPath) -> Bool)?
  open var rowShouldHighlight = true

  public func bind(to tableView: UITableView) {
    self.tableView = tableView
    tableView.delegate = self
    tableView.dataSource = self
  }

  open override func onItemsChanged() {
    tableView?.reloadData()
  }

  // MARK: UITableViewDataSource
  open func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows
  }

  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
    preConfigureCellBlock?(cell, indexPath)
    configureTableViewCell(cell, atIndexPath: indexPath)
    return cell
  }


  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectedItem?(item(at:indexPath),indexPath)
    if !allowSelection{
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.didDeselectedItem?(item(at:indexPath),indexPath)
  }

  /// abstract
  open func configureTableViewCell(_ cell:UITableViewCell,atIndexPath indexPath:IndexPath){
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

  // MARK: UITableViewDelegate
  public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    if let block = shouldHilightRow{
      return block(indexPath)
    }else{
      return rowShouldHighlight
    }
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return fallbackDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
  }

}
