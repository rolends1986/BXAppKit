//
//  FloatSidePanelPresentationController.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 30/07/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

public enum FloatSide{
  case top,left,right,bottom
}

open class FloatSidePanelPresentationController:UIPresentationController{
  lazy var dimmingView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    view.alpha  = 0.0
    return view
  }()

  public var dimissOnTapDimmingView = true
  public var floatSide = FloatSide.right

  open override var frameOfPresentedViewInContainerView : CGRect {
    let bounds = containerView!.bounds
    let floatSize =  presentedViewController.preferredContentSize.width
    let edge:CGRectEdge
    switch floatSide {
    case .top:
      edge = CGRectEdge.minYEdge
    case .left:
      edge = CGRectEdge.minXEdge
    case .bottom:
      edge = CGRectEdge.maxYEdge
    case .right:
      edge = CGRectEdge.maxXEdge
    }
    return bounds.divided(atDistance: floatSize, from: edge).slice
  }

  public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
    dimmingView.addGestureRecognizer(tap)
  }

  func dimmingViewTapped(gesture:UITapGestureRecognizer) {
    if gesture.state == .ended && dimissOnTapDimmingView{
      presentingViewController.dismiss(animated: true, completion: nil)
    }
  }

  open override func presentationTransitionWillBegin() {
    let containerView = self.containerView!
    let presentedVC = self.presentedViewController
    //    let presentingVC = self.presentingViewController
    // Set the dimming view to the size of the container's bounds, and make it transparent initialy
    dimmingView.frame = containerView.bounds
    dimmingView.alpha = 0.0
    // Insert the dimming view below everything
    containerView.insertSubview(dimmingView, at: 0)

    // Set up the animations for fading in the dimming view.
    if let coordinator = presentedVC.transitionCoordinator{
      coordinator.animate(alongsideTransition: { (ctx) -> Void in
        // Fade ind
        self.dimmingView.alpha = 1.0
      }, completion: { (ctx) -> Void in

      })
    }else{
      self.dimmingView.alpha = 0.0
    }

  }

  open override func presentationTransitionDidEnd(_ completed: Bool) {
    // If the presentation was canceld, remove the dimming view.
    if !completed{
      self.dimmingView.removeFromSuperview()
    }
  }

  open override func dismissalTransitionWillBegin() {
    // Fade the dimming view back out
    if let coordinator = presentedViewController.transitionCoordinator{
      coordinator.animate(alongsideTransition: { (ctx) -> Void in
        self.dimmingView.alpha = 0.0
      }, completion: nil)

    }else{
      self.dimmingView.alpha = 1.0
    }
  }

  open override func dismissalTransitionDidEnd(_ completed: Bool) {
    // If the dismissal was successful, remove the dimming view
    if completed{
      self.dimmingView.removeFromSuperview()
    }
  }
}
