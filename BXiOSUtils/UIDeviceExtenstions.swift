//
//  UIDeviceExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit



public extension UIDevice{
  /// 判断当前设置是否是模拟器
  public static var isSimulator:Bool{
    #if arch(i386) || arch(x86_64)
      return true
    #else
      return false
    #endif
  }

  public static var isLandscape:Bool{
    return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
  }

  public static var isPortrait:Bool{
    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
  }

  public static var is40InchScreen:Bool{
    let dw = UIScreen.deviceWidth
    let dh = UIScreen.deviceHeight
    return Int(dw) == 320 && Int(dh) == 568
  }

  public static var is35InchScreen:Bool{
    let dw = UIScreen.deviceWidth
    let dh = UIScreen.deviceHeight
    return Int(dw) == 320 && Int(dh) == 480
  }

  public static var is47InchScreen:Bool{
    let dw = UIScreen.deviceWidth
    let dh = UIScreen.deviceHeight
    return Int(dw) == 375 && Int(dh) == 667
  }

  public static var is55InchScreen:Bool{
    let dw = UIScreen.deviceWidth
    let dh = UIScreen.deviceHeight
    return Int(dw) == 416 && Int(dh) == 736
  }

  public static var isIpad:Bool{
    return current.userInterfaceIdiom == .pad
  }

  public static var isIpadPro:Bool{
    return isIpad && Int(UIScreen.deviceWidth) == 1024 && Int(UIScreen.deviceHeight) == 1366
  }

  public static var isIphone:Bool{
    return current.userInterfaceIdiom == .phone
  }

}

public extension UIScreen{

  /// 屏幕宽度，跟横竖屏无关
  public static var deviceWidth:CGFloat{
    if UIDevice.isLandscape{
      return main.bounds.height
    }else{
      return main.bounds.width
    }
  }

  /// 屏幕高度，跟横竖屏无关
  public static var deviceHeight:CGFloat{
    if UIDevice.isLandscape{
      return main.bounds.width
    }else{
      return main.bounds.height
    }
  }

  /// 是不是 320 宽度的小屏幕
  public static var isSmallScreen:Bool{
    return deviceWidth < 330 // 比如 iPhone 5s 及 SE
  }
}


