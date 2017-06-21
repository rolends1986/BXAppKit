//
//  SimpleGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit

open class SimpleGenericTableViewAdapter<T,V:UITableViewCell>: BaseSimpleTableViewAdapter<T> where V:BXBindable {
  open var preBindCellBlock:( (V,IndexPath) -> Void )?
  open var postBindCellBlock:( (V,IndexPath) -> Void )?
  open var configureCellBlock:( (V,IndexPath) -> Void )?
  public typealias WillDisplayCellBlock = ( (V,_ withItem:T,_ atIndexPath:IndexPath) -> Void )
  open var willDisplayCellBlock: WillDisplayCellBlock?

  open func itemAtIndexPath(_ indexPath:IndexPath) -> T{
    return items[(indexPath).row]
  }

  @nonobjc
  open func bindTo(_ tableView:UITableView){
    super.bind(to: tableView)
    self.reuseIdentifier = simpleClassName(V.self)+"_cell"
    if V.hasNib{
      tableView.register(V.nib(), forCellReuseIdentifier: reuseIdentifier)
    }else{
      tableView.register(V.self, forCellReuseIdentifier: reuseIdentifier)
    }
  }

  // MARK: UITableViewDataSource
  open  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellForRowAtIndexPath(indexPath)
  }
  
  open func cellForRowAtIndexPath(_ indexPath:IndexPath) -> V {
    let cell = tableView!.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! V
    preConfigureCellBlock?(cell,indexPath)
    let model = itemAtIndexPath(indexPath)
    preBindCellBlock?(cell,indexPath)
    if let m = model as? V.ModelType{
      cell.bind(m)
    }
    configureCell(cell, atIndexPath: indexPath)
    postBindCellBlock?(cell,indexPath)
    return cell
  }
  
  open func configureCell(_ cell:V,atIndexPath indexPath:IndexPath){
    self.configureCellBlock?(cell,indexPath)
  }
  


  open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let item = itemAtIndexPath(indexPath)
    if let subCell = cell as? V{
      self.willDisplayCellBlock?(subCell,item,indexPath)
    }
  }


  
}
