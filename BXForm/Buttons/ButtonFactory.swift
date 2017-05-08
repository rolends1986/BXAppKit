//
//  ButtonFactory.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

import UIKit
import BXiOSUtils

extension UIButton{
  
  public  func setupAsRedButton(){
    setBackgroundImage(UIImage.bx.image(fillColor: FormColors.redColor), for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  public func setupAsAccentButton(){
    setBackgroundImage(FormButtons.accentImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  public func setupAsPrimaryActionButton(){
    setBackgroundImage(FormButtons.primaryImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
}

public struct FormButtons{
  
  public static func backgroundImage(_ color:UIColor) -> UIImage{
    let cornerRadius = FormMetrics.cornerRadius
    let size = CGSize(width: 64, height: 64)
    let image = UIImage.bx.roundImage(fillColor: color, size: size, cornerRadius: cornerRadius)
    let buttonImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    return buttonImage
  }
  
  public static let accentImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let primaryImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let lightGrayImage = FormButtons.backgroundImage(FormColors.lightGrayColor)
  
}
