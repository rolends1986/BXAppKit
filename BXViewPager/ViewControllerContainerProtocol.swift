//
//  ViewControllerContainerProtocol.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 11/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

/// 用做一个 View Container 的容器的协议. containerView 用来布局  子 VC
/// 当然 VC.view 本身也可以作为 containerView
public protocol ViewControllerContainerProtocol{
  var containerView:UIView { get }
  // 往往是实现此协议的 ViewController 本身
  var containerViewController: UIViewController{ get }
  func addChildViewController(_ childController: UIViewController)
  func transition(from fromViewController: UIViewController, to toViewController: UIViewController, duration: TimeInterval, options: UIViewAnimationOptions, animations: (() -> Swift.Void)?, completion: ((Bool) -> Swift.Void)?)
  
}

/// 提示便于操作 子 VC 的扩展
extension ViewControllerContainerProtocol{
  public func putChildControllerIntoContainerView(_ controller:UIViewController){
    putChildController(controller, into: containerView)
  }

  public func putChildController(_ controller:UIViewController, into containerView:UIView){
    addChildViewController(controller)
    containerView.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.pac_edge()
    controller.didMove(toParentViewController: containerViewController)
  }

  /// 用于计算 子 ViewController 的切换时要进场的 VC 的 frame
  func newViewStartFrame(_ direction:UIPageViewControllerNavigationDirection) -> CGRect{
    let frame = containerView.bounds
    if direction == .forward{
      return frame.offsetBy(dx: frame.width, dy: 0)
    }else{
      return frame.offsetBy(dx:-frame.width, dy: 0)
    }
  }

  /// 用于计算 子 ViewController 的切换时要 退场的 VC 的 frame
  func oldViewEndFrame(_ direction:UIPageViewControllerNavigationDirection) -> CGRect{
    let frame = containerView.bounds
    if direction == .forward{
      return frame.offsetBy(dx: -frame.width, dy: 0)
    }else{
      return frame.offsetBy(dx:frame.width, dy: 0)
    }
  }


  public func switchFromViewController(_ oldVC:UIViewController,toViewController newVC:UIViewController,navigationDirection:UIPageViewControllerNavigationDirection = .forward){
    // Prepare the two view controllers for the change.
    oldVC.willMove(toParentViewController: nil)
    self.addChildViewController(newVC)

    // Get the start frame of the new view controller and the end frame
    // for the old view controller. Both rectangles are offscreen
    //    containerView.addSubview(newVC.view) // 至少 iOS 9 transitionFromViewController 时 会自动添加
    newVC.view.frame = newViewStartFrame(navigationDirection)
    let oldEndFrame = oldViewEndFrame(navigationDirection)
    let newEndFrame = oldVC.view.frame

    transition(from: oldVC, to: newVC, duration: 0.25, options: UIViewAnimationOptions(), animations: { () -> Void in
      // Animate the views to their final positions
      newVC.view.frame = newEndFrame
      oldVC.view.frame = oldEndFrame
    }) { (finished) -> Void in
      // Remove the old view Controller and send the final
      // notification to the new view Controller
      oldVC.view.removeFromSuperview()
      oldVC.removeFromParentViewController()
      newVC.didMove(toParentViewController: self.containerViewController)
//      self.currentVisibleController = newVC // NOTE

    }
  }

  func displayTabViewController(_ controller:UIViewController){
    addChildViewController(controller)
    controller.view.frame = frameForTabViewController
    self.containerView.addSubview(controller.view)
    controller.didMove(toParentViewController: containerViewController)
//    self.currentVisibleController = controller // NOTE
  }

  var frameForTabViewController:CGRect{
    return containerView.bounds

  }

}
