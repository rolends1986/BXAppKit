//
//  ViewController.swift
//  BXAppKitDemo
//
//  Created by Haizhen Lee on 21/04/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit
import PinAuto

//AppTab
//form:BXForm
//model:BXModel
//other:其他
enum AppTab:Int{
  case form
  case model
  case other
  var isForm:Bool{ return self == .form }
  var isModel:Bool{ return self == .model }
  var isOther:Bool{ return self == .other }

  var title:String{
    switch self{
    case .form:return "BXForm"
    case .model:return "BXModel"
    case .other:return "其他"
    }
  }

  static let allCases:[AppTab] = [.form, .model, .other ]
}

extension AppTab{
  var tabItem:UITabBarItem{
    let item = UITabBarItem(title: title, image: nil, tag: rawValue)
    return item
  }

  var viewController: UIViewController{
    let vc = UIViewController(nibName: nil, bundle: nil)
    vc.tabBarItem = tabItem
    return vc
  }
}


class MainTabViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = AppTab.allCases.map{ $0.viewController }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

