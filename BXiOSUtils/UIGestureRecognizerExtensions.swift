//
//  UIGestureRecognizerExtensions.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 04/08/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer.State{
  public var name:String{
    switch self {
    case .possible: return "possible"
    case .began: return "began"
    case .failed: return "failed"
    case .cancelled: return "cancelled"
    case .changed: return "changed"
    case .ended: return "ended"
    }
  }
}
