//
//  PaddingButton.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 28/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

open class PaddingButton:UIButton{
  open var horizontalPadding:CGFloat = 0
  open var verticalPadding: CGFloat = 0

  open override var intrinsicContentSize : CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + horizontalPadding * 2, height: size.height + verticalPadding*2)
  }
}
