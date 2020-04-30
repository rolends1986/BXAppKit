//
//  LabelSpanCell.swift
//
//  Created by Haizhen Lee on 16/6/26.
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import BXiOSUtils

//-LabelLabelCell:stc
//label[w85,y](f17,cpt)
//span[at4@label,r15,y](f15,cst)

public final class LabelSpanCell : StaticTableViewCell, LeadingLabelRow{
    public let labelLabel = UILabel(frame:.zero)
    public let spanLabel = UILabel(frame:.zero)
    
    
    public convenience init() {
        self.init(style: .default, reuseIdentifier: "LabelSpanCell")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var allOutlets :[UIView]{
        return [labelLabel,spanLabel]
    }
    
    public var allUILabelOutlets :[UILabel]{
        return [labelLabel,spanLabel]
    }
    
    public func commonInit(){
        for childView in allOutlets{
            contentView.addSubview(childView)
            childView.translatesAutoresizingMaskIntoConstraints = false
        }
        installConstaints()
        setupAttrs()
        
    }
    
    public var isOneLineMode = true{
        didSet{
            onLineModeChanged()
        }
    }
    
    private func onLineModeChanged(){
        labelYConstraint?.isActive =  isOneLineMode
        labelTopConstraint?.isActive = !isOneLineMode
        
        spanLabel.numberOfLines = isOneLineMode ? 1: 0
        spanBottomConstraint?.isActive = !isOneLineMode
        spanTopConstraint?.isActive = !isOneLineMode
        spanCenterYConstraint?.isActive = isOneLineMode
    }
    public var paddingLeft:CGFloat = FormMetrics.cellPaddingLeft{
        didSet{
            paddingLeftConstraint?.constant = paddingLeft
        }
    }
    
    public var paddingRight:CGFloat = FormMetrics.cellPaddingRight{
        didSet{
            paddingRightConstraint?.constant = paddingRight
        }
    }
    
    public var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
        didSet{
            labelWidthConstraint?.constant = labelWidth
        }
    }
    
    public  var paddingLeftConstraint:NSLayoutConstraint?
    fileprivate var paddingRightConstraint:NSLayoutConstraint?
    public var labelWidthConstraint:NSLayoutConstraint?
    
    public var labelTopConstraint: NSLayoutConstraint?
    public var labelYConstraint: NSLayoutConstraint?
    
    public var spanTopConstraint:NSLayoutConstraint?
    public var spanCenterYConstraint:NSLayoutConstraint?
    public var spanBottomConstraint:NSLayoutConstraint?
    
    
    public func installConstaints(){
        labelYConstraint =  labelLabel.pa_centerY.install()
        labelTopConstraint =  labelLabel.pa_top.eq(8).install()
        
        paddingLeftConstraint =  labelLabel.pa_leadingMargin.eq(paddingLeft).install()
        labelWidthConstraint = labelLabel.pa_width.eq(labelWidth).install()
        spanLabel.pa_after(labelLabel,offset:8).install()
        paddingRightConstraint =  spanLabel.pa_trailingMargin.eq(paddingRight).install()
        spanCenterYConstraint =  spanLabel.pa_centerY.install()
        spanTopConstraint = spanLabel.pa_top.eq(8).install()
        spanBottomConstraint = spanLabel.pa_bottom.eq(8).install()
        
    }
    
    public func setupAttrs(){
        setupLeadingLabel()
        
        spanLabel.textColor = FormColors.secondaryTextColor
        spanLabel.font = UIFont.systemFont(ofSize:FormMetrics.secondaryFontSize)
        spanLabel.textAlignment = .right
        accessoryType = .disclosureIndicator
        
        isOneLineMode = true
    }
    
    
    public var span:String?{
        get{ return spanLabel.text }
        set{ spanLabel.text = newValue }
    }
}

public extension LabelSpanCell{
    public func calcHeight(maxWidth:CGFloat) -> CGFloat{
        let margins = contentView.layoutMargins
        spanLabel.preferredMaxLayoutWidth = maxWidth - labelWidth  - 8 - margins.left - margins.right - paddingLeft - paddingRight
        let calcSize = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return max(ceil(calcSize.height) + 16, 60)
    }
}
