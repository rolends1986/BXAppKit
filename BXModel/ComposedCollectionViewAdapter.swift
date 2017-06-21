//
//  ComposedCollectionViewAdapter.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 21/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit

public protocol ComposableCollectionViewAdapter:class, UICollectionViewDataSource,UICollectionViewDelegate{
  func bind(to collectionView:UICollectionView)
}

open class ComposedCollectionViewAdapter:NSObject,UICollectionViewDataSource, UICollectionViewDelegate{
  open fileprivate(set) weak var collectionView:UICollectionView?
  public private(set) var childAdapters:[ComposableCollectionViewAdapter] = []

  open func bind(to collectionView:UICollectionView){
    self.collectionView = collectionView
    rebind(to: collectionView)
  }

  private func rebind(to collectionView:UICollectionView){
    for ds in childAdapters{
      ds.bind(to: collectionView)
    }
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  public func add(adapter: ComposableCollectionViewAdapter){
    childAdapters.append(adapter)
    if let tv = collectionView{
      rebind(to: tv)
    }
    collectionView?.reloadData()
  }

  public func update(adapters:[ComposableCollectionViewAdapter]){
    childAdapters = adapters
    if let tv = collectionView{
      rebind(to: tv)
    }
    collectionView?.reloadData()
  }

  // MARK: UICollectionViewDataSource

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return childAdapters.count
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return childAdapters[section].collectionView(collectionView,numberOfItemsInSection:section)
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return childAdapters[indexPath.section].collectionView(collectionView,cellForItemAt:indexPath)
  }

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    childAdapters[indexPath.section].collectionView?(collectionView,didSelectItemAt:indexPath)
  }
}
