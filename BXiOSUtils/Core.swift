//
//  Core.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 28/04/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation


public protocol BanxiExtensions{
  associatedtype Base
  var base:Base { get }
}

public struct Banxi<Base>: BanxiExtensions{
  public let base:Base

  public init(_ base:Base){
    self.base = base
  }
}

public protocol BanxiExtensionsProvider:class{}


public extension BanxiExtensionsProvider{
  public var bx:Banxi<Self>{
    return Banxi(self)
  }

  public static var bx: Banxi<Self>.Type{
    return Banxi<Self>.self
  }

}

extension NSObject: BanxiExtensionsProvider{}

extension BanxiExtensions where Base:NSObject{
  
}
