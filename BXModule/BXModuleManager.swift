//
//  BXModuleManager.swift
//  Pods
//
//  Created by Haizhen Lee on 11/14/16.
//
//

import Foundation


open class BXModuleManager: NSObject{
  public static var shared = BXModuleManager()
  private var _modules = [BXModule]()
  
  public func all() -> [BXModule]{
      return _modules
  }
  
  public func add(module: BXModule){
    if _modules.contains(where: { $0.isEqual(module) }) {
      NSLog("Ignore duplicate add module \(module)")
    }else{
      _modules.append(module)
    }
  }
  
  
}

extension BXModuleManager: UIApplicationDelegate{
  
  // MARK: normal lifecycle
  
  public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    NSLog("\(#function) \(application)  \(String(describing: launchOptions))")
    for module in all(){
      let _ = module.application?(application, willFinishLaunchingWithOptions: launchOptions)
    }
    return true
  }
  
  public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    NSLog("\(#function) \(application)  \(String(describing: launchOptions))")
    for module in all(){
      let _ = module.application?(application, didFinishLaunchingWithOptions: launchOptions)
    }
    return true
  }
  
  public func applicationWillResignActive(_ application: UIApplication) {
    NSLog("\(#function) \(application) ")
    for module in all(){
      module.applicationWillResignActive?(application)
    }
  }
  
  public func applicationDidEnterBackground(_ application: UIApplication) {
    NSLog("\(#function) \(application) ")
    for module in all(){
      module.applicationDidEnterBackground?(application)
    }
  }
  
  public func applicationWillEnterForeground(_ application: UIApplication) {
    NSLog("\(#function) \(application) ")
    for module in all(){
      module.applicationWillEnterForeground?(application)
    }
  }
 
  public func applicationDidBecomeActive(_ application: UIApplication) {
    NSLog("\(#function) \(application) ")
    for module in all(){
      module.applicationDidBecomeActive?(application)
    }
  }
  
  public func applicationWillTerminate(_ application: UIApplication) {
    NSLog("\(#function) \(application)")
    for module in all(){
      module.applicationWillTerminate?(application)
    }
  }
  
  // MARK:  Remote Notification
 
  // 已经实现了下面的 带fetchCompletionHandler 的方法,此方法就不会再调用
//  public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//    for module in all(){
//      module.application?(application, didReceiveRemoteNotification: userInfo)
//    }
//  }
//  
  public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    for module in all(){
        module.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
  }
  
  public func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
    NSLog("\(#function) \(application)")
    for module in all(){
      module.application?(application, didRegister: notificationSettings)
    }
  }
 
  public  func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
    NSLog("\(#function) \(application)")
    for module in all(){
      module.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, completionHandler: completionHandler)
    }
  }
  
  public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    NSLog("\(#function) \(application)")
    for module in all(){
      module.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
  }
  
  public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NSLog("\(#function) \(application)")
    for module in all(){
      module.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
  }
  
  // MARK: Local Notification
  
  public func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
    
    NSLog("\(#function) \(application)")
    for module in all(){
      module.application?(application, didReceive: notification)
    }
  }
  
}
