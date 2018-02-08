//
//  SimpleTableViewAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 21/04/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit

open class SimpleTableViewAdapter<T:UITableViewCell>: BaseSimpleTableViewAdapter<T.ModelType> where T:BXBindable {


  open var preBindCellBlock:( (T, T.ModelType, IndexPath) -> Void )?
  open var postBindCellBlock:( (T,T.ModelType, IndexPath) -> Void )?
  public typealias WillDisplayCellBlock = ( (T,T.ModelType,IndexPath) -> Void )
  open var willDisplayCellBlock: WillDisplayCellBlock?

 


  public init(tableView:UITableView? = nil,items:[T.ModelType] = []){
    super.init(items: items)
    if let tableView = tableView{
      bind(to: tableView)
    }
  }

  open  override func bind(to tableView:UITableView){
    super.bind(to: tableView)
    self.reuseIdentifier = simpleClassName(T.self)+"_cell"
    if T.hasNib{
      tableView.register(T.nib(), forCellReuseIdentifier: reuseIdentifier)
    }else{
      tableView.register(T.self, forCellReuseIdentifier: reuseIdentifier)
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
    cell.bind(model,indexPath: indexPath)
    postConfigure(cell: cell, model: model, indexPath: indexPath)
  }

  open func postConfigure(cell:T,model:T.ModelType,indexPath:IndexPath){
    postBindCellBlock?(cell,model, indexPath)
  }


  //MARK: UITableViewDelegate
  open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let model = item(at:indexPath)
    if let subCell = cell as? T{
      self.willDisplayCellBlock?(subCell,model,indexPath)
    }
  }

}
