//
//  SimpleGenericTableViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/20.
//
//

import UIKit

/// 极简 tableViewController
/// 数据设置可通过 公开的 adapter 对象,直接对 adapter 进行设置
open class SimpleTableViewController<V:UITableViewCell>: UITableViewController where V:BXBindable{

  typealias ItemType = V.ModelType
  
  public private(set) var adapter:SimpleTableViewAdapter<V> = SimpleTableViewAdapter()
 
  public typealias DidSelectedItemBlock = ( (V.ModelType,IndexPath) -> Void )
  open var didSelectedItemBlock: DidSelectedItemBlock?{
    didSet{
      adapter.didSelectedItem = didSelectedItemBlock
    }
  }

  open override func loadView() {
    super.loadView()
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = 88
    tableView.rowHeight = UITableViewAutomaticDimension
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    adapter.bind(to: tableView)
    adapter.didSelectedItem = didSelectedItemBlock
  }
  
}
