//
//  SimpleCollectionViewDataSource.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit

open class SimpleCollectionViewDataSource<T>: BaseDataSource<T>,UICollectionViewDataSource{
    // MARK: UICollectionViewDataSource
    
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
    
    // MARK : Helper
    
    open func configureCollectionViewCell(_ cell:UICollectionViewCell,atIndexPath indexPath:IndexPath){
        
    }
    
}
