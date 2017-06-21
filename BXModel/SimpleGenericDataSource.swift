//
//  GenericDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit


open class SimpleGenericDataSource<T>:BaseDataSource<T>, UITableViewDataSource, UICollectionViewDataSource{
    open var section = 0
    public typealias ItemType = T
    

   open func itemAtIndexPath(_ indexPath:IndexPath) -> T{
        return items[(indexPath).row]
    }
    
   open func numberOfRows() -> Int {
        return self.items.count
   }
  
    
    // MARK: UITableViewDataSource
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        configureTableViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDataSource

   public final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return numberOfRows()
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
   open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        configureCollectionViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK : Helper
    
    open func configureCollectionViewCell(_ cell:UICollectionViewCell,atIndexPath indexPath:IndexPath){
        
    }
    
   open func configureTableViewCell(_ cell:UITableViewCell,atIndexPath indexPath:IndexPath){
        
    }
  
}
