//
//  SimplePickerAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 11/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

public protocol PickerItem{
  var title:String { get }
}

public protocol ComposablePickerViewAdapter:class, UIPickerViewDataSource, UIPickerViewDelegate {
  func bind(to pickerView:UIPickerView)
  /// NOTE set 功能 仅供 ComposedPickerAdapter 使用
  var component:Int { get set }
}


/// 单列的 UIPickerView Adapter
open class SimplePickerAdapter<T:PickerItem>:NSObject,ComposablePickerViewAdapter{
  public private(set) var items:[T] = []
  public var rowHeight:CGFloat = 36
  public var component = 0
  public var font:UIFont = UIFont.systemFont(ofSize: 13)
  public var textColor:UIColor = UIColor.darkText
  public var didSelectItem: ((T) -> Void)?
  public weak var pickerView:UIPickerView?

  public init(items:[T]){
    self.items = items
  }

  public func bind(to picker:UIPickerView){
      self.pickerView = picker
      picker.dataSource = self
      picker.delegate = self
      picker.reloadComponent(component)
  }

  public func updateItems(_ items:[T]){
    self.items = items
    pickerView?.reloadComponent(component)
  }
  

  // MARK: UIPickerViewDataSource
  // returns the number of 'columns' to display.
  public func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
  }

  // returns the # of rows in each component..
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    return items.count
  }

  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
    return rowHeight
  }


  public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?{
    let item = items[row]
    let attrStr = NSAttributedString(string: item.title, attributes: [
        NSAttributedString.Key.foregroundColor:textColor,
        NSAttributedString.Key.font:font
      ])
    return attrStr
  }

  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    let item = items[row]
    didSelectItem?(item)
  }

  public var currentSelectedItem:T?{
    if let row = pickerView?.selectedRow(inComponent: component){
      return items[row]
    }
    return nil
  }

}

open class ComposedPickerViewAdapter:NSObject,UIPickerViewDataSource,UIPickerViewDelegate{
  open fileprivate(set) weak var pickerView:UIPickerView?
  public fileprivate(set) var childAdapters:[ComposablePickerViewAdapter] = []

  open func bind(to pickerView:UIPickerView){
    self.pickerView = pickerView
    pickerView.delegate = self
    pickerView.dataSource = self
  }

  public func add(adapter:ComposablePickerViewAdapter){
    childAdapters.append(adapter)
    adapter.component = childAdapters.count - 1
  }

  public func update(adapters:[ComposablePickerViewAdapter]){
    childAdapters.removeAll()
    for adapter in adapters{
      add(adapter: adapter)
    }
  }

  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return childAdapters.count
  }

  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return childAdapters[component].pickerView(pickerView,numberOfRowsInComponent:component)
  }

  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    childAdapters[component].pickerView?(pickerView, didSelectRow: row, inComponent: component)
  }




}
