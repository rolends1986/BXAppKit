//
//  RadioItem.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

public protocol RadioOption:Equatable,Hashable{
  var title:String { get }
}

extension RadioOption{
  public static func ==(lhs:Self,rhs:Self) -> Bool{
    return lhs.title == rhs.title
  }

  var hashValue:Int{
    return title.hashValue
  }
}

