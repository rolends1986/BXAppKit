//
//  AttributedTextFactory.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

open  class AttributedTextCreator{
  public var textColor:UIColor
  public var font:UIFont

  public init(textColor:UIColor = .darkText, font:UIFont = UIFont.systemFont(ofSize: 15)){
    self.textColor = textColor
    self.font = font
  }

  public func create(text:String) -> NSAttributedString{
     return NSAttributedString(string: text, attributes: [
        NSAttributedString.Key.font:font,
        NSAttributedString.Key.foregroundColor:textColor
      ])
  }
  
}


public struct AttributedText{
  public var textColor:UIColor
  public var font:UIFont
  public fileprivate(set) var text:String
  
  public init(text:String,fontSize: CGFloat = 15,fontWeight:UIFont.Weight = .regular, textColor:UIColor = UIColor.darkText){
    self.init(text:text, font: UIFont.systemFont(ofSize: fontSize,weight:fontWeight), textColor: textColor)
  }
  
  public init(text:String,font:UIFont = UIFont.systemFont(ofSize: 15),textColor:UIColor = UIColor.darkText){
    self.text = text
    self.font = font
    self.textColor = textColor
  }
  
  
  public var attributedText:NSAttributedString{
    return NSAttributedString(string: text, attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.foregroundColor:textColor])
  }
}




public struct TextFactory{
  public static func createAttributedText(_ textAttributes:[AttributedText]) -> NSAttributedString{
    let attributedText = NSMutableAttributedString()
    for attr in textAttributes{
      attributedText.append(attr.attributedText)
    }
    return attributedText
  }
  
  public static func createAttributedText(_ textAttributes:[NSAttributedString]) -> NSAttributedString{
    let attributedText = NSMutableAttributedString()
    for attr in textAttributes{
      attributedText.append(attr)
    }
    return attributedText
  }
  

  
}
