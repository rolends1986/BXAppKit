//
//  GapCell.swift
//  Pods
//

import UIKit
import BXModel

public final class GapCell : StaticTableViewCell{
    
    
    public convenience init() {
        self.init(height:10)
    }
    
    public convenience init(height:CGFloat) {
        self.init(style: .default, reuseIdentifier: "GapCellCell")
        staticHeight = height
        removeSeparator = true
        bx_removeSeparator()
        
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    var allOutlets :[UIView]{
        return []
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        backgroundColor = FormColors.backgroundColor
    }
}
