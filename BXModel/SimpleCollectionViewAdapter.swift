//
//  SimpleCollectionViewAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 13/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

open class SimpleCollectionViewAdapter<T:UICollectionViewCell>: SimpleCollectionViewDataSource<T.ModelType> where T:BXBindable {

  open var didSelectedItem: DidSelectedItemBlock?
  open var preBindCellBlock:( (T, T.ModelType, IndexPath) -> Void )?
  open var postBindCellBlock:( (T,T.ModelType, IndexPath) -> Void )?
  public typealias WillDisplayCellBlock = ( (T,T.ModelType,IndexPath) -> Void )
  open var willDisplayCellBlock: WillDisplayCellBlock?

  public override init(items: [T.ModelType] = []) {
    super.init(items: items)
    self.reuseIdentifier = simpleClassName(T.self)
  }

  public func bind(to collectionView:UICollectionView){
    collectionView.dataSource = self
    collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
  }


  open override func configureCollectionViewCell(_ cell: UICollectionViewCell, atIndexPath indexPath: IndexPath) {
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

}
