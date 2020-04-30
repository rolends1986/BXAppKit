//
//  BasicInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/6.
//  Copyright © 2016年 xiyili. All rights reserved.
//


import UIKit
import BXModel
import BXiOSUtils


public final class BasicInputCell : StaticTableViewCell{
    public let textField = UITextField(frame:CGRect.zero)
    
    
    public convenience init() {
        self.init(style: .default, reuseIdentifier: "BasicInputCellCell")
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
        return [textField]
    }
    var allUITextFieldOutlets :[UITextField]{
        return [textField]
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func commonInit(){
        staticHeight = 65
        for childView in allOutlets{
            contentView.addSubview(childView)
            childView.translatesAutoresizingMaskIntoConstraints = false
        }
        installConstaints()
        setupAttrs()
        
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
    
    fileprivate var paddingLeftConstraint:NSLayoutConstraint?
    fileprivate var paddingRightConstraint:NSLayoutConstraint?
    
    public func installConstaints(){
        paddingLeftConstraint =  textField.pa_leadingMargin.eq(paddingLeft).install() // pa_leading.eq(15)
        paddingRightConstraint =  textField.pa_trailingMargin.eq(paddingRight).install() // pa_trailing.eq(15)
        textField.pa_bottom.eq(10).install() //pinBottom(10)
        textField.pa_top.eq(10).install() // pa_top.eq(10)
        
    }
    
    public func setupAttrs(){
        textField.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
        textField.backgroundColor = FormColors.textFieldBackgroundColor
        textField.textColor = FormColors.accentColor
    }
}

extension BasicInputCell{
    public var inputText:String{
        get{ return textField.text?.trimmed() ?? "" }
        set{ textField.text = newValue }
    }
    
    public var placeholder:String?{
        get{ return textField.placeholder }
        set{
            if let str = newValue{
                textField.attributedPlaceholder = NSAttributedString(string: str,attributes:[
                     .font: UIFont.systemFont(ofSize: FormMetrics.secondaryFontSize),
                     .foregroundColor: FormColors.hintTextColor
                ])
            }else{
                textField.attributedPlaceholder = nil
            }
            
        }
    }
}

