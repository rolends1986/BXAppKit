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

  public func setupBackgroundImage(color:UIColor,
                                   disableColor:UIColor = UIColor.gray,
                                   cornerRadius:CGFloat = FormMetrics.cornerRadius){
    backgroundColor = nil
    let normalBg = FormButtons.backgroundImage(color, cornerRadius: cornerRadius)
    let disabledBg = FormButtons.backgroundImage(disableColor,cornerRadius: cornerRadius)
    setBackgroundImage(normalBg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(UIColor.white, for: .normal)

  }

  public  func setupAsRedButton(){
    setBackgroundImage(FormButtons.redImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControl.State())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  public func setupAsAccentButton(){
    setBackgroundImage(FormButtons.accentImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.darkText, for: UIControl.State())
    setTitleColor(UIColor.lightGray, for: .disabled)
  }
  
  public func setupAsPrimaryActionButton(){
    setBackgroundImage(FormButtons.primaryImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(FormColors.primaryButtonTextColor, for: .normal)
    setTitleColor(UIColor.lightGray, for: .disabled)
  }

  public func setupAsPrimarySemiCircleButton(){
    let bg = FormButtons.semiCircleAccentImage
    let disabledBg = FormButtons.semiCircleAccentDisabledImage
    setBackgroundImage(bg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(FormColors.primaryButtonTextColor, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }

  public func setupAsPrimarySemiCircleLargeButton(){
    let bg = FormButtons.semiCircleLargeAccentImage
    let disabledBg = FormButtons.semiCircleLargeAccentDisabledImage
    setBackgroundImage(bg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(FormColors.primaryButtonTextColor, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 18)
  }

  public func setupAsPrimarySemiCircleOutlineButton(){
    let bg = FormButtons.semiCircleOutlineAccentImage
    let disabledBg = FormButtons.semiCircleOutlineAccentDisabledImage
    setBackgroundImage(bg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(FormColors.accentColor, for: .normal)
    setTitleColor(FormColors.accentDisabledColor, for: .disabled)
    titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }

  public func setupAsPrimarySemiCircleOutlineLargeButton(){
    let bg = FormButtons.semiCircleOutlineLargeAccentImage
    let disabledBg = FormButtons.semiCircleOutlineLargeAccentDisabledImage
    setBackgroundImage(bg, for: .normal)
    setBackgroundImage(disabledBg, for: .disabled)
    setTitleColor(FormColors.accentColor, for: .normal)
    setTitleColor(FormColors.accentDisabledColor, for: .disabled)
    titleLabel?.font = UIFont.systemFont(ofSize: 18)
  }

}

public struct FormButtons{

  public static func makeSemiCircleButtonBackground(color:UIColor, height:CGFloat = 30, width:CGFloat = 40) -> UIImage{
    let size = CGSize(width:width, height:height)
    let img = UIImage.bx.roundImage(fillColor: color, size:size, cornerStyle: .semiCircle)
    let insets =  UIEdgeInsets(top: 0, left: height * 0.5, bottom: 0, right: height * 0.5)
    return img.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }

  public static func makeSemiCircleOutlineButtonBackground(borderColor:UIColor, borderWidth:CGFloat = 0.5, height:CGFloat = 30, width:CGFloat = 40) -> UIImage{
       let size = CGSize(width:width, height:height)
    let img = UIImage.bx.roundImage(size: size, cornerStyle: .semiCircle, borderWidth:borderWidth, borderColor: borderColor)
    let insets = UIEdgeInsets(top: 0, left: height * 0.5, bottom: 0, right: height * 0.5)
    return img.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }

  public static func backgroundImage(_ color:UIColor,cornerRadius:CGFloat = FormMetrics.cornerRadius) -> UIImage{
    let size = CGSize(width: 30, height: 30)
    let image = UIImage.bx.roundImage(fillColor: color, size: size, cornerStyle: .radius(cornerRadius))
    let buttonImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    return buttonImage
  }


  public static let semiCircleAccentImage = FormButtons.makeSemiCircleButtonBackground(color: FormColors.accentColor)

  public static let semiCircleAccentDisabledImage = FormButtons.makeSemiCircleButtonBackground(color: FormColors.accentDisabledColor)

  public static let semiCircleLargeAccentImage = FormButtons.makeSemiCircleButtonBackground(color: FormColors.accentColor,height: 44,width: 88)
  public static let semiCircleLargeAccentDisabledImage = FormButtons.makeSemiCircleButtonBackground(color: FormColors.accentDisabledColor,height: 44,width: 88)

  public static let semiCircleOutlineAccentImage = FormButtons.makeSemiCircleOutlineButtonBackground(borderColor: FormColors.accentColor)
  public static let semiCircleOutlineAccentDisabledImage = FormButtons.makeSemiCircleOutlineButtonBackground(borderColor: FormColors.accentDisabledColor)

  public static let semiCircleOutlineLargeAccentImage = FormButtons.makeSemiCircleOutlineButtonBackground(borderColor: FormColors.accentColor,height:44,width: 88)
  public static let semiCircleOutlineLargeAccentDisabledImage = FormButtons.makeSemiCircleOutlineButtonBackground(borderColor: FormColors.accentDisabledColor,height:44,width: 88)

  public static let redImage = FormButtons.backgroundImage(FormColors.redColor)
  public static let accentImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let primaryImage = FormButtons.backgroundImage(FormColors.accentColor)
  public static let lightGrayImage = FormButtons.backgroundImage(FormColors.lightGrayColor)
  
}
