//
//  IconButton.swift
//
//  Created by Haizhen Lee on 15/11/10.
//

import UIKit

open class IconButton:UIButton{
  open var iconPadding = FormMetrics.iconPadding{
    didSet{
      titleEdgeInsets = UIEdgeInsets(top: 0, left: icon == nil ? 0: iconPadding, bottom: 0, right: 0)
      invalidateIntrinsicContentSize()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      setNeedsLayout()
    }
  }
  
  open var lineWidth :CGFloat = 0.5 {
    didSet{
      setNeedsLayout()
    }
  }
  
  lazy var maskLayer:CALayer = {
    let layer = CALayer()
    self.layer.mask = layer
    return layer
  }()
  
  
  open override var intrinsicContentSize : CGSize {
      let size = super.intrinsicContentSize
      let padding = icon == nil ? 0 : iconPadding
      return CGSize(width: size.width + padding, height: size.height)
  }
  
  open var icon:UIImage?{
    set{
      setImage(newValue, for: .normal)
      titleEdgeInsets = UIEdgeInsets(top: 0, left: newValue == nil ? 0: iconPadding, bottom: 0, right: 0)
      invalidateIntrinsicContentSize()
    }get{
      return image(for: .normal)
    }
  }
}
