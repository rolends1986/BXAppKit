//
//  RightInfoCell.swift
//
//  Created by Haizhen Lee on 16/5/23.
//  Copyright © 2016年 banxi1988. All rights reserved.
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils


public   class RightInfoCell : UITableViewCell {
    
    
    public convenience init() {
        self.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "RightInfoCell")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    
    
    
    public func bind(_ title:String,detail:String? = nil ){
        textLabel?.text = title
        detailTextLabel?.text = detail
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var allOutlets :[UIView]{
        return []
    }
    
    func commonInit(){
        for childView in allOutlets{
            contentView.addSubview(childView)
            childView.translatesAutoresizingMaskIntoConstraints = false
        }
        installConstaints()
        setupAttrs()
        
    }
    
    func installConstaints(){
    }
    
    func setupAttrs(){
        textLabel?.textColor = FormColors.primaryTextColor
        textLabel?.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
        
        detailTextLabel?.textColor = FormColors.primaryTextColor
        detailTextLabel?.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
        
        accessoryType = .disclosureIndicator
        bx_removeSeperatorInset()
    }
    
    
}
