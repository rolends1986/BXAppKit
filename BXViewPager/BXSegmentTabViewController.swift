//
//  BXSegmentTabViewController.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 11/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit



open class BXSegmentTabViewController:UIViewController,ViewControllerContainerProtocol{
  open var containerView = UIView(frame: .zero)
  public var containerViewController: UIViewController{ return self}

  public private(set) var segmentIndexViewControllerMap:[Int:UIViewController] = [:]

  public let segmentControl = UISegmentedControl(frame: .zero)

  public func add(segmentTitle:String,viewController:UIViewController) -> Int{
    let index = segmentControl.numberOfSegments
    segmentIndexViewControllerMap[index] = viewController
    segmentControl.insertSegment(withTitle: segmentTitle, at: index, animated: false)
    return index
  }

  private var previousSelectedSegmentIndex = -1

  open override func loadView() {
    super.loadView()
    view.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.pac_horizontal(0)
    containerView.pa_below(topLayoutGuide).install()
    containerView.pa_above(bottomLayoutGuide).install()
    automaticallyAdjustsScrollViewInsets = false
    
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    setupSegmentTab()
    segmentControl.addTarget(self, action: #selector(onSelectedSegmentalChanged), for: .valueChanged)
    segmentControl.sizeToFit()
    navigationItem.titleView = segmentControl
    if segmentControl.numberOfSegments > 0 {
      showSegmentTab(index: 0)
    }
  }

  /// setup segment tab before
  open func setupSegmentTab(){
    
  }

  @objc func onSelectedSegmentalChanged(){
    showSegmentTab(index: segmentControl.selectedSegmentIndex)
  }

  public func showSegmentTab(index:Int){
    if index == previousSelectedSegmentIndex{
      return
    }
    var oldTabVC:UIViewController?
    if previousSelectedSegmentIndex > -1{
      oldTabVC = segmentIndexViewControllerMap[previousSelectedSegmentIndex]
    }
    guard let newTabVC = segmentIndexViewControllerMap[index] else{
      return
    }
    if let oldVC = oldTabVC{
      let direction : UIPageViewControllerNavigationDirection  = (index  > previousSelectedSegmentIndex) ? .forward : .reverse
      switchFromViewController(oldVC, toViewController: newTabVC, navigationDirection: direction)
    }else{
      displayTabViewController(newTabVC)
    }

    previousSelectedSegmentIndex = index
  }

  
  
}
