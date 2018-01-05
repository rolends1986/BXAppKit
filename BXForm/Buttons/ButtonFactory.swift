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

  public func setupBackgroundImage(color:UIColor){
    backgroundColor = nil
    let normalBg = FormButtons.backgroundImage(color)
    let disabledBg = FormButtons.backgroundImage(UIColor.gray)
    setBackgroundImage(normalBg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(UIColor.white, for: .normal)

  }

  public  func setupAsRedButton(){
    setBackgroundImage(FormButtons.redImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  public func setupAsAccentButton(){
    setBackgroundImage(FormButtons.accentImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.darkText, for: UIControlState())
    setTitleColor(UIColor.lightGray, for: .disabled)
  }
  
  public func setupAsPrimaryActionButton(){
    setBackgroundImage(FormButtons.primaryImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.darkText, for: .normal)
    setTitleColor(UIColor.lightGray, for: .disabled)
  }
}

public struct FormButtons{

  public static func makeSemiCircleButtonBackground(color:UIColor, height:CGFloat = 30, width:CGFloat = 88) -> UIImage{
    let size = CGSize(width:width, height:height)
    let img = UIImage.bx.roundImage(fillColor: color, size:size, cornerStyle: .semiCircle)
    let insets =  UIEdgeInsets(top: 4, left: height * 0.5, bottom: 4, right: height * 0.5)
    return img.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }

  public static func makeSemiCircleOutlineButtonBackground(borderColor:UIColor, borderWidth:CGFloat = 0.5, height:CGFloat = 30, width:CGFloat = 88) -> UIImage{
       let size = CGSize(width:width, height:height)
    let img = UIImage.bx.roundImage(size: size, cornerStyle: .semiCircle, borderWidth:borderWidth, borderColor: borderColor)
    let insets = UIEdgeInsets(top: 4, left: height * 0.5, bottom: 4, right: height * 0.5)
    return img.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }

  public static func backgroundImage(_ color:UIColor,cornerRadius:CGFloat = FormMetrics.cornerRadius) -> UIImage{
    let size = CGSize(width: 30, height: 30)
    let image = UIImage.bx.roundImage(fillColor: color, size: size, cornerStyle: .radius(cornerRadius))
    let buttonImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    return buttonImage
  }


  public static let semiCircleAccentImage = FormButtons.makeSemiCircleButtonBackground(color: FormColors.accentColor)
  public static let semiCircleOutlineAccentImage = FormButtons.makeSemiCircleOutlineButtonBackground(borderColor: FormColors.accentColor)

  public static let redImage = FormButtons.backgroundImage(FormColors.redColor)
  public static let accentImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let primaryImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let lightGrayImage = FormButtons.backgroundImage(FormColors.lightGrayColor)
  
}
