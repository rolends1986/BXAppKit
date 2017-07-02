//
//  SimpleCollectionViewDataSource.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit

open class BaseSimpleCollectionViewAdapter<T>: BaseDataSource<T>,ComposableCollectionViewAdapter{
    // MARK: UICollectionViewDataSource

  open var didSelectedItem: DidSelectedItemBlock?
  open fileprivate(set) weak var collectionView:UICollectionView?

  public func bind(to collectionView: UICollectionView) {
    self.collectionView = collectionView
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  
    public final  func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public final  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return numberOfRows
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        configureCollectionViewCell(cell, atIndexPath: indexPath)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      didSelectedItem?(item(at: indexPath), indexPath)
    }
    
    // MARK : Helper
    
    open func configureCollectionViewCell(_ cell:UICollectionViewCell,atIndexPath indexPath:IndexPath){
        
    }

  open override func onItemsChanged() {
    collectionView?.reloadData()
  }
    
}
