//
//  UIStackViewExtentions.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 20/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

public extension UIStackView{
  public func removeAllArrangedSubview(){
    for subview in arrangedSubviews{
      removeArrangedSubview(subview)
      subview.removeFromSuperview()
    }
  }

  public func addArrangedSubviews(_ views:[UIView]){
    for child in views{
      addArrangedSubview(child)
    }
  }
}
