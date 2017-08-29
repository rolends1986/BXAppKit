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
    // NOTE 这里 setViewControllers 的第一个参数要用 animated: false
    // 另外不能直接先将 vc append vcArray 再 set
    // 这样会导致有时候需要 hideBottomBarWhenPush 生效必须要用 push
    setViewControllers(vcArray, animated: false)
    pushViewController(viewController, animated: true)
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
  /// 但是不应该将 rootViewController 弹出
  public func popTwoViewController(animated:Bool = true){
    var  vcArray = viewControllers
    if vcArray.count > 1{
      let _ = vcArray.popLast()
    }
    if vcArray.count > 1{
      let _ = vcArray.popLast()
    }
    setViewControllers(vcArray, animated: animated)
  }
}
