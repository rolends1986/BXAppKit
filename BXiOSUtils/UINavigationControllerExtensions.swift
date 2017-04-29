//
//  UINavigationControllerExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/30.
//
//

import Foundation

import UIKit

public extension UINavigationController{

  /// 替换掉 Nav 栈最上面的 Controller
  public func replaceTopViewControllerWith(_ viewController:UIViewController){
    var  vcArray = viewControllers
    let _ = vcArray.popLast()
    vcArray.append(viewController)
    setViewControllers(vcArray, animated: true)
  }

  @available(*, deprecated, renamed: "replaceTopViewControllerWith")
  public func bx_replaceTopViewController(with viewController:UIViewController){
    replaceTopViewControllerWith(viewController)
  }

  @available(*,deprecated, renamed: "popTwoViewController")
  public func bx_popTwoViewController(_ animated:Bool = true){
    popTwoViewController()
  }

  /// 一次弹出两个 Controller (如果有的话)
  public func popTwoViewController(animated:Bool = true){
    var  vcArray = viewControllers
    if !vcArray.isEmpty{
      let _ = vcArray.popLast()
    }
    if !vcArray.isEmpty{
      let _ = vcArray.popLast()
    }
    setViewControllers(vcArray, animated: animated)
  }
}
