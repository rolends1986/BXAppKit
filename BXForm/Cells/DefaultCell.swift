//
//  DefaultCell.swift
//
//  Created by Haizhen Lee on 16/7/4.
//  Copyright © 2016年 banxi1988. All rights reserved.
//

import UIKit
import BXModel

public final class DefaultCell : StaticTableViewCell{
    
    
    public convenience init() {
        self.init(style: .default, reuseIdentifier: "DefaultCell")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
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
        staticHeight = 44
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
    }
    
    
}
