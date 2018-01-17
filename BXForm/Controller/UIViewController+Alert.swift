//
//  UIViewController+Alert.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/31.
//
//

import UIKit

public extension UIViewController{
  public func bx_prompt(_ message:String, handler:@escaping ((Bool) -> Void)){
    let confirmController = ConfirmAlertController(title: "", message: message, preferredStyle: .alert)
    confirmController.onConfirmCallback = {
      sure in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            handler(sure)
        }

    }
    present(confirmController, animated: true, completion: nil)
  }
  
  public func bx_confirm(_ message:String,closure:(() -> Void)? = nil){
    let confirmController = ConfirmAlertController(title: "", message: message, preferredStyle: .alert)
    confirmController.shouldShowCancelButton = false
    confirmController.onConfirmCallback = {
      sure in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            closure?()
        }

    }
    present(confirmController, animated: true, completion: nil)
  }
}
