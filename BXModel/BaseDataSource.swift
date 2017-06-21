//
//  BaseDataSource.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


open class BaseDataSource<T>:NSObject{
    open var reuseIdentifier = "cell"
    open fileprivate(set) var items = [T]()
    public typealias ItemType = T
    public typealias DidSelectedItemBlock = ( (T,_ atIndexPath:IndexPath) -> Void )
    
    public init(items:[T] = []){
        self.items = items
    }
    
    
    open func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        onItemsChanged()
    }
    
    open func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
        self.items.append(contentsOf: items)
        onItemsChanged()
    }
    
    open func insert(_ item:T,at index :Int){
        self.items.insert(item, at: index)
        onItemsChanged()
    }
    
    open func onItemsChanged(){
        
    }

    
}

public typealias SimpleGenericDataSource<T> = BaseDataSource<T>

extension BaseDataSource{
    open func item(at indexPath:IndexPath) -> T{
        return items[indexPath.row]
    }
    
    open var numberOfRows: Int {
        return self.items.count
    }
    
    open var numberOfItems:Int{
        return self.items.count
    }
    
}






extension BaseDataSource where T:Equatable{
    public func index(of item:T) -> Int?{
        return self.items.index(of: item)
    }
    
    public func remove(at index:Int) -> T{
        let item =  items.remove(at: index)
        onItemsChanged()
        return item
    }
    
    public func remove(_ item:T) -> T?{
        if let index = self.items.index(of: item){
            return remove(at: index)
        }
        return nil
    }
    
    public func removeItems(_ items:[T]){
        for item in items{
            let _ = remove(item)
        }
    }
}

