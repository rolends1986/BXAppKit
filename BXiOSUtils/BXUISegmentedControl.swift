//
//  BXUISegmentedControl.swift
//  BXiOSUtils
//
//  Created by qinjilei on 2020/4/27.
//  Copyright © 2020 banxi1988. All rights reserved.
//


import UIKit

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        ctx.fill(CGRect(origin: .zero, size: size))
        guard
            let image = UIGraphicsGetImageFromCurrentImageContext(),
            let imagePNGData = image.pngData()
            else { return nil }
        UIGraphicsEndImageContext()
        
        self.init(data: imagePNGData)
    }
}
extension UISegmentedControl {
    
    public  func fallBackToPreIOS13Layout(using tintColor: UIColor) {
        if #available(iOS 13, *) {
            let backGroundImage = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
            let dividerImage = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))
            
            setBackgroundImage(backGroundImage, for: .normal, barMetrics: .default)
            setBackgroundImage(dividerImage, for: .selected, barMetrics: .default)
            
            setDividerImage(dividerImage,
                            forLeftSegmentState: .normal,
                            rightSegmentState: .normal, barMetrics: .default)
            
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
            
            setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
            setTitleTextAttributes([.foregroundColor: UIColor(hex: 0x0b0000)], for: .selected)
        } else {
            self.tintColor = tintColor
        }
    }
}
open class BXUISegmentedControl: UISegmentedControl {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 13.0, *) {
            for subview in subviews {
                //                if let selectedImageView = subview.subviews.last(where: { $0 is UIImageView }) as? UIImageView,
                //                    let image = selectedImageView.image {
                //                    selectedImageView.image = image.withRenderingMode(.alwaysTemplate)
                //                    break
                //                }
                //解决ios 13 显示不全的问题
                for subSubview in subview.subviews{
                    if subSubview is UILabel{
                        let label=subSubview as! UILabel
                        label.translatesAutoresizingMaskIntoConstraints = false
                        let constraintCenterX = NSLayoutConstraint.init(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0)
                        subview.addConstraint(constraintCenterX)
                        
                        let constraintCenterY = NSLayoutConstraint.init(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
                        subview.addConstraint(constraintCenterY)
                        
                        let constraintWidth = NSLayoutConstraint.init(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subview, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0)
                        subview.addConstraint(constraintWidth)
                    }
                }
                
                
            }
        }
        
    }
    
}
