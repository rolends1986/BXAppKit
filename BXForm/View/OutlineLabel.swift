//
//  OutlineLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 16/6/8.
//
//

import UIKit
import BXiOSUtils

open class OutlineLabel:PaddingLabel{
  
  open var borderColor:UIColor = UIColor(hex: 0xe0e0e0){
    didSet{
      layer.borderColor = borderColor.cgColor
    }
  }

  open var outlineStyle:CornerStyle = .radius(4){
    didSet{
      updateCornerRadius()
    }
  }
  
  open var borderWidth:CGFloat = 1.5{
    didSet{
      layer.borderWidth = borderWidth
    }
  }
  
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    updateCornerRadius()
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
    clipsToBounds = true
  }

  func updateCornerRadius(){
    switch outlineStyle {
    case .oval:
      layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
    case .semiCircle:
      layer.cornerRadius = bounds.height * 0.5
    case .radius(let rd):
      layer.cornerRadius = rd
    case .none:
      layer.cornerRadius = 0
    }
  }
}
