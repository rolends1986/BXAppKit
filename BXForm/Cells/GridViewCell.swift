//
//  LinearGridCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/7/8.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils

//-LinearGridCell:stc
//gridView[e0]:v

public final class GridViewCell : StaticTableViewCell {
    public let gridView = GridView(frame:CGRect.zero)
    
    
    public convenience init() {
        self.init(style: .default, reuseIdentifier: "LinearGridCellCell")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _commonInit()
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        _commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func _commonInit(){
        contentView.addSubview(gridView)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        gridView.pac_edge(0, left: 0, bottom: 0, right: 0)
        
    }
    
}
