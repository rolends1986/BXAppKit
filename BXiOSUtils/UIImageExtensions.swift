//
//  UIImageExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public enum BorderPosition{
  case inside
  case center
  case outside
}

public enum CornerStyle{
  case oval
  case semiCircle
  case radius(CGFloat)
  case none
}

public extension BanxiExtensions where Base:UIImage{

  public static func roundImage(fillColor:UIColor? = nil,
                                size:CGSize=CGSize(width: 32, height: 32),
                                padding:CGFloat = 0,
                                cornerStyle:CornerStyle = .radius(4),
                                borderPosition:BorderPosition = .inside,
                                borderWidth:CGFloat = 0,
                                borderColor:UIColor? = nil
    ) -> UIImage{
    // 为 border 腾出点地方
    // size 参数定义的是画而大小, inset 之后的才是绘制的大小.
    let inset:CGFloat
    if borderWidth > 0 {
      switch borderPosition {
      case .inside:
        inset = borderWidth
      case .outside:
        inset = 0
      case .center:
        inset = borderWidth * 0.5
      }
    }else{
      inset = 0
    }
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    let pathRect = rect.insetBy(dx: inset + padding, dy: inset + padding)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clear.setFill()
    ctx?.fill(rect)
    fillColor?.setFill()
    borderColor?.setStroke()
    let path:UIBezierPath
    switch cornerStyle {
    case .oval:
        path = UIBezierPath(ovalIn: pathRect)
    case .semiCircle:
       let radius = pathRect.height * 0.5
        path = UIBezierPath(roundedRect: pathRect, cornerRadius: radius)
    case .radius(let rd):
        path = UIBezierPath(roundedRect: pathRect, cornerRadius: rd)
    case .none:
        path = UIBezierPath(rect: pathRect)
    }
    path.lineWidth  = borderWidth
    if fillColor != nil{
      path.fill()
    }
    if borderWidth > 0 && borderColor != nil {
      path.stroke()
    }
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }

  public static func circleImage(fillColor:UIColor,radius:CGFloat,padding:CGFloat  = 0) -> UIImage{
    let size = CGSize(width: radius * 2, height: radius * 2)
    let cornerRadius = radius
    return roundImage(fillColor:fillColor, size: size, padding: 0, cornerStyle: .radius(cornerRadius))
  }


  public static func transparentImage(size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clear.setFill()
    ctx?.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }

  public static func image(fillColor:UIColor,width:CGFloat) -> UIImage{
    return image(fillColor:fillColor, size: CGSize(width: width, height: width))
  }

  public static func image(fillColor:UIColor,size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    let ctx = UIGraphicsGetCurrentContext()
    fillColor.setFill()
    ctx?.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }

  public static func placeholder(_ width:CGFloat) -> UIImage{
    return placeholder(size:CGSize(width: width, height: width))
  }

  public static func placeholder(size:CGSize) -> UIImage{
    return image(fillColor:UIColor.white, size: size)
  }



  public static func createImage(text:String,
                                 backgroundColor:UIColor,
                                    textColor:UIColor,
                                    font:UIFont,
                                    diameter:CGFloat) -> UIImage {
    let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
    let attrs = [NSFontAttributeName:font,
                 NSForegroundColorAttributeName:textColor
    ]
    let textFrame = text.boundingRect(with: frame.size, options:.usesFontLeading, attributes: attrs, context: nil)

    let dx = frame.midX - textFrame.midX
    let dy = frame.midY - textFrame.midY
    let drawPoint = CGPoint(x: dx, y: dy)
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.saveGState()
    backgroundColor.setFill()
    ctx?.fill(frame)
    text.draw(at: drawPoint, withAttributes: attrs)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    ctx?.restoreGState()
    UIGraphicsEndImageContext()
    return image!
  }

  /**
   diameter:直径
   **/
  public  func circularImage(diameter:CGFloat, highlightedColor:UIColor? = nil) -> UIImage {
    let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
    UIGraphicsBeginImageContextWithOptions(frame.size, false,0.0)
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.saveGState()
    let imgPath = UIBezierPath(ovalIn: frame)
    imgPath.addClip()
    base.draw(in: frame)
    if let color = highlightedColor{
      color.setFill()
      ctx?.fillEllipse(in: frame)
    }
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!

  }

  public  func highlightImage(highlightedColor:UIColor? = nil,circular:Bool=true) -> UIImage {
    let frame = CGRect(x: 0, y: 0, width: base.size.width , height: base.size.height )
    let color = highlightedColor ?? UIColor(white: 0.1, alpha: 0.3)
    UIGraphicsBeginImageContextWithOptions(frame.size, false,base.scale)
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.saveGState()
    if circular{
      let imgPath = UIBezierPath(ovalIn: frame)
      imgPath.addClip()
    }else{
      let imgPath = UIBezierPath(roundedRect: frame, cornerRadius: 10)
      imgPath.addClip()
    }
    base.draw(in: frame)
    color.setFill()
    if circular{
      ctx?.fillEllipse(in: frame)
    }else{
      ctx?.fill(frame)
    }
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

  /**
   *  判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
   */
  public var isOpaque:Bool{
    guard let alphaInfo = base.cgImage?.alphaInfo else{
      return true
    }

    return alphaInfo == .noneSkipLast
      || alphaInfo == .noneSkipFirst
      || alphaInfo == .none
  }

  public func withAlpha(_ alpha:CGFloat) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(base.size, false,base.scale)
    let drawingRect = CGRect(origin: .zero, size: base.size)
    base.draw(in: drawingRect, blendMode: .normal, alpha: alpha)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

  public func grayImage() -> UIImage?{
     // CGBitmapContextCreate 是无倍数的，所以要自己换算成1倍
     let width = base.size.width * base.scale
     let height = base.size.height * base.scale
      let colorSpace = CGColorSpaceCreateDeviceGray()
    guard let ctx = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: (0 << 12)) else{
      return nil
    }
    let imgRect = CGRect(x: 0, y: 0, width: width, height: height)
    ctx.draw(base.cgImage!, in: imgRect)
    guard let img = ctx.makeImage() else{
      return nil
    }
    if isOpaque{
      return UIImage(cgImage: img, scale: base.scale, orientation: base.imageOrientation)
    }else{
      let space  = CGColorSpaceCreateDeviceRGB()
      guard let alphaCtx = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue) else{
        return nil
      }
      alphaCtx.draw(base.cgImage!, in: imgRect)
      guard let mask = alphaCtx.makeImage() else{
        return nil
      }
      let maskedGrayImg = img.masking(mask)
      // 用 CGBitmapContextCreateImage 方式创建出来的图片，CGImageAlphaInfo 总是为 CGImageAlphaInfoNone，导致 qmui_opaque 与原图不一致，所以这里再做多一步
      let grayImage = UIImage(cgImage: maskedGrayImg!, scale: base.scale, orientation: base.imageOrientation)
      UIGraphicsBeginImageContextWithOptions(grayImage.size, false, grayImage.scale)
      grayImage.draw(in: imgRect)
      let finalImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return finalImage
    }
  }

//  public func withTintColor(_ tintColor:UIColor) -> UIImage{
//    let imgRect = CGRect(origin: .zero, size: base.size)
//    UIGraphicsBeginImageContextWithOptions(base.size, isOpaque, base.scale)
//    let ctx = UIGraphicsGetCurrentContext()
//    ctx?.translateBy(x: 0, y: imgRect.height)
//    ctx?.scaleBy(x: 1.0, y: -1.0)
//    ctx?.setBlendMode(.normal)
//    ctx?.clip(to: imgRect, mask: base.cgImage!)
//    ctx?.setFillColor(tintColor.cgColor)
//    ctx?.fill(imgRect)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return newImage!
//  }

  public func withTintColor(_ tintColor:UIColor) -> UIImage{
    let templateImage = base.withRenderingMode(.alwaysTemplate)
    UIGraphicsBeginImageContextWithOptions(templateImage.size, false, templateImage.scale)
    tintColor.set()
    templateImage.draw(at: CGPoint.zero)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

  public func withPaddings(_ paddings:UIEdgeInsets) -> UIImage{
    let newWidth = base.size.width + paddings.left + paddings.right
    let newHeight = base.size.height + paddings.top + paddings.bottom
    let newSize = CGSize(width: newWidth, height: newHeight)
    UIGraphicsBeginImageContextWithOptions(newSize, isOpaque, base.scale)
    base.draw(at: CGPoint(x: paddings.left, y: paddings.right))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

}


public extension UIImage{


  @available(*,deprecated, renamed: "bx.transparentImage")
  public class func bx_transparentImage(_ size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    return bx.transparentImage(size:size)
  }
  

  @available(*,deprecated, renamed: "bx.circleImage")
  public static func bx_circleImage(_ color:UIColor,radius:CGFloat) -> UIImage{
    return bx.circleImage(fillColor:color,radius:radius)
  }

  @available(*,deprecated, renamed: "bx.roundImage")
  public static func bx_roundImage(_ color:UIColor,size:CGSize=CGSize(width: 32, height: 32),cornerRadius:CGFloat = 4) -> UIImage{
    return bx.roundImage(fillColor:color, size: size, cornerStyle: .radius(cornerRadius), borderWidth: 0, borderColor: nil)
  }
  

  
  

  
}

public extension UIImage{

  @available(*,deprecated, renamed: "rawImage")
  public var bx_rawImage:UIImage{
    return self.withRenderingMode(.alwaysOriginal)
  }

  public var rawImage:UIImage{
    return self.withRenderingMode(.alwaysOriginal)
  }

  public var templateImage:UIImage{
    return self.withRenderingMode(.alwaysTemplate)
  }
}


