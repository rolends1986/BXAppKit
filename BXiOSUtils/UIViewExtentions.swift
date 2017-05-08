//
//  UIViewExtentions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension BanxiExtensions where Base: UIView{
  public var width:CGFloat{
    set{
      var frame = base.frame
      frame.size.width = newValue
      base.frame = frame
    }get{
      return base.frame.width
    }
  }

  public var height:CGFloat{
    set{
      var frame = base.frame
      frame.size.height = newValue
      base.frame = frame
    }get{
      return base.frame.height
    }
  }
  
 
  public var size:CGSize{
    set{
      var frame = base.frame
      frame.size = newValue
      base.frame = frame
    }get{
      return base.frame.size
    }
  }
  
  public var origin:CGPoint{
    set{
      var frame = base.frame
      frame.origin = newValue
      base.frame = frame
    }get{
      return base.frame.origin
    }
  }
 
  public var centerX:CGFloat{
    set{
      base.center = CGPoint(x: newValue,y: base.center.y)
    }get{
      return base.center.x
    }
  }
  
  public var centerY:CGFloat{
    set{
      base.center = CGPoint(x: centerY,y: newValue)
    }get{
      return base.center.y
    }
  }
  
  
  public var minX:CGFloat{
    set{
      var frame = base.frame
      frame.origin.x = newValue
      base.frame = frame
    }get{
      return base.frame.minX
    }
  }
  
  public var maxX:CGFloat{
    set{
      var frame = base.frame
      frame.origin.x = newValue - frame.width
      base.frame = frame
    }get{
      return base.frame.maxX
    }
  }
  
  public var minY:CGFloat{
    set{
      var frame = base.frame
      frame.origin.y = newValue
      base.frame = frame
    }get{
      return base.frame.minY
    }
  }
  
  public var maxY:CGFloat{
    set{
      var frame = base.frame
      frame.origin.y = newValue - frame.height
      base.frame = frame
    }get{
      return base.frame.maxY
    }
  }
  
}

public extension UIView{
  public struct DrawSettings{
    public static var seperatorLineWidth :CGFloat = .onePixel
    public static var seperatorLineColor : UIColor = UIColor(white: 0.912, alpha: 1.0)
    public static var gapRectColor:UIColor = UIColor(white: 0.88, alpha: 1.0)
    public static var gapRectHeight :CGFloat = 10
  }
  public func bx_drawLineAtY(_ y:CGFloat,inset:CGFloat=15){
    DrawSettings.seperatorLineColor.set()
    let lineRect = CGRect(x: 0, y: y, width: bounds.width, height: DrawSettings.seperatorLineWidth).insetBy(dx: inset, dy: 0)
    UIRectFill(lineRect)
  }
  
  public func bx_drawLineAtY(_ y:CGFloat,leadingInset inset:CGFloat=54){
    DrawSettings.seperatorLineColor.set()
    let lineRect = CGRect(x: inset, y: y, width: bounds.width - inset, height: DrawSettings.seperatorLineWidth)
    UIRectFill(lineRect)
  }
  
  public func bx_drawGapRect(_ atBottom:Bool = true,atTop:Bool = false){
    DrawSettings.gapRectColor.setFill()
    if atBottom {
      let gapRect = bounds.divided(atDistance: DrawSettings.gapRectHeight, from: CGRectEdge.maxYEdge).slice
      UIRectFill(gapRect)
    }
    if atTop{
      let gapRect = bounds.divided(atDistance: DrawSettings.gapRectHeight, from: CGRectEdge.minYEdge).slice
      UIRectFill(gapRect)
    }
  }
}
