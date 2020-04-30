//
//  BXTabViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/6.
//
//

import UIKit
import PinAuto



open class BXTabViewController: BXTabLayoutViewController,ViewControllerContainerProtocol{
 
  var currentVisibleController:UIViewController?

  public var containerViewController: UIViewController{
    return self
  }

  open override var currentPageViewController:UIViewController?{
    return currentVisibleController
  }
  
  open override func showPageAtIndex(_ index:Int){
    if viewControllers.isEmpty{
      return
    }
    let currentIndex = currentPageIndex() ?? -1
    if currentIndex == index{
      return
      
    }
    
    let direction:UIPageViewController.NavigationDirection = index > currentIndex ? .forward:.reverse
    let nextVC = viewControllers[index]
    guard let prevVC = currentVisibleController else{
      displayTabViewController(nextVC)
      return
    }
    switchFromViewController(prevVC, toViewController: nextVC,navigationDirection: direction)
    
  }
  
  
  
}



