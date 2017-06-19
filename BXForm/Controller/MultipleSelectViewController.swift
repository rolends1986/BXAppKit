//
//  MultipleSelectViewController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/12.
//


import UIKit
import SwiftyJSON
import BXModel



/// 表示一个 "选项" 对象.
/// 只要求有一个可用于显示的字符串.
/// 为了多选要求其支持 Hashable
public protocol Option:Hashable{
  var displayLabel:String { get }
}

/// String 天然的满足 Option 协议的要求.
extension String: Option{
  public var displayLabel: String{
    return self
  }
}

/// 选项 Cell 支持自定义,但是需要继承自 BaseOptionCell
///
open class BaseOptionCell:UITableViewCell,BXBindable{
  public func bind(_ item:String){
    textLabel?.text = item
  }
}



let optionCellIdentifier = "optionCell"

open class MultipleSelectViewController<T:Option>: UITableViewController{
  open fileprivate(set) var options:[T] = []
  open let dataSource  = BaseSimpleTableViewAdapter<T>()
  open fileprivate(set) var selectedItems :Set<T> = []
  open var completionHandler : ( (Set<T>) -> Void )?
  open var onSelectOption:((T) -> Void)?
  open var multiple = true
  open var showSelectToolbar = true
  open var isSelectAll = false


  public convenience init(){
    self.init(options:[],style: .grouped)
  }

  public init(options:[T], style:UITableViewStyle = .plain){
    self.options = options
    dataSource.updateItems(options)
    super.init(style: style)
    tableView.register(BaseOptionCell.classForCoder(), forCellReuseIdentifier: optionCellIdentifier)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  public func register(_ cellClass:BaseOptionCell.Type){
      tableView.register(cellClass.classForCoder(), forCellReuseIdentifier: optionCellIdentifier)
  }
  
  open func updateOptions(_ options:[T]){
    self.options.removeAll()
    self.options.append(contentsOf: options)
    dataSource.updateItems(options)
  }

  open func setInitialSelectedItems<S:Sequence>(_ items:S) where S.Iterator.Element == T{
    selectedItems.removeAll()
    selectedItems.formUnion(items)
  }


  open var selectAllButton:UIBarButtonItem?
  fileprivate var originalToolbarHidden: Bool?
  open override func loadView() {
    super.loadView()
    originalToolbarHidden = navigationController?.isToolbarHidden
    if showSelectToolbar{
      navigationController?.isToolbarHidden = false
      navigationController?.toolbar.tintColor = FormColors.primaryColor
      let leftSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let selectAllButton = UIBarButtonItem(title:isSelectAll ? "全不选": "全选", style: .plain, target: self, action: #selector(MultipleSelectViewController.selectAllButtonPressed(_:)))
      selectAllButton.tintColor = UIColor.blue
      toolbarItems = [leftSpaceItem,selectAllButton]
      self.selectAllButton = selectAllButton
    }
  }


  func selectAllButtonPressed(_ sender:AnyObject){
    isSelectAll = !isSelectAll
    selectAllButton?.title = isSelectAll ? "全不选": "全选"
    if isSelectAll{
      selectedItems.formUnion(options)
    }else{
      selectedItems.removeAll()
    }
    tableView.reloadData()
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    dataSource.updateItems(options)//
    tableView.dataSource = dataSource

    dataSource.configureCellBlock = { (cell,indexPath) in
      let item = self.dataSource.item(at:indexPath)
      if let mcell = cell as? BaseOptionCell{
        mcell.bind(item.displayLabel)
      }
      cell.accessoryType =  self.selectedItems.contains(item) ? .checkmark: .none
    }
    
    tableView.tableFooterView = UIView()
    if multiple{
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MultipleSelectViewController.selectDone(_:)))
      self.navigationItem.rightBarButtonItem = doneButton
    }

  }

  func selectDone(_ sender:AnyObject){
    self.completionHandler?(selectedItems)
    #if DEBUG
      NSLog("selectDone")
    #endif
    let poped = navigationController?.popViewController(animated: true)
    if poped == nil{
      dismiss(animated: true, completion: nil)
    }
  }

  func onSelectItem(_ item:T,atIndexPath indexPath:IndexPath){
    guard let  cell = tableView.cellForRow(at: indexPath) else{
      return
    }


    if selectedItems.contains(item){
      selectedItems.remove(item)
    }else{
      selectedItems.insert(item)
    }

    let isChecked = selectedItems.contains(item)
    cell.accessoryType = isChecked ? .checkmark : .none

    if !multiple{
      self.onSelectOption?(item)
      selectDone(cell)
    }
  }

  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if let state = originalToolbarHidden{
      navigationController?.setToolbarHidden(state, animated: true)
    }
  }

  // MARK: UITableViewDelegate
  open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }

  open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let option = dataSource.item(at: indexPath)
    onSelectItem(option, atIndexPath: indexPath)
  }

}
