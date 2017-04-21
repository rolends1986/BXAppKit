//
//  SimpleTableViewDataSource.swift
//  BXUI
//
//  Created by Haizhen Lee on 2/22/17.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

import UIKit


open class SimpleTableViewDataSource<T>:BaseDataSource<T>,UITableViewDataSource{
    open var cellClass: UITableViewCell.Type = UITableViewCell.self

    open var configureCellBlock:((UITableViewCell,IndexPath) -> Void)?
    
    // MARK: UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        configureTableViewCell(cell, atIndexPath: indexPath)
        configureCellBlock?(cell, indexPath)
        return cell
    }
    
    /// abstract
    open func configureTableViewCell(_ cell:UITableViewCell,atIndexPath indexPath:IndexPath){
    }
    
    
}
