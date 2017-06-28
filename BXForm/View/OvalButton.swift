//
//  OvalButton.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/29.
//
//


import UIKit
import BXiOSUtils

open class OvalButton:PaddingButton{
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    updateOvalPath()
  }
  
  open var outlineStyle : CornerStyle = .oval{
    didSet{
      updateOvalPath()
    }
  }

  fileprivate func updateOvalPath(){
    let path:UIBezierPath
    switch outlineStyle{
    case .radius(let cornerRadius):
      path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    case .oval:
      path = UIBezierPath(ovalIn: bounds)
    case .semiCircle:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * 0.5)
    case .none:
      maskLayer.path = nil
      layer.mask = nil
      return
    }
    maskLayer.path = path.cgPath
  }
}
