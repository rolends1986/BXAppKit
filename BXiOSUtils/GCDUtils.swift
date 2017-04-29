//
//  GCDUtils.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import Foundation


/// 在后台线程异步执行
public func async(_ block:@escaping ()->()){
  DispatchQueue.global().async(execute: block)
}

@available(*,deprecated, renamed: "async")
public func bx_async(_ block:@escaping ()->()){
  DispatchQueue.global().async(execute: block)
}



public func asyncUtility(_ block:@escaping ()->()){
  DispatchQueue.global(qos: .utility).async(execute: block)
}

public func asyncBackground(_ block:@escaping ()->()){
  DispatchQueue.global(qos: .background).async(execute: block)
}

public func asyncUserInitiated(_ block:@escaping ()->()){
  DispatchQueue.global(qos: .userInitiated).async(execute: block)
}

public func asyncUserInteractive(_ block:@escaping ()->()){
  DispatchQueue.global(qos: .userInteractive).async(execute: block)
}

/// 在 UI 线程 暨 主线程中执行
public func ui(_ block:@escaping ()->()){
  if Thread.isMainThread{
    block()
  }else{
    DispatchQueue.main.async(execute: block)
  }
}


@available(*, deprecated, renamed: "ui")
public func bx_runInUiThread(_ block:@escaping ()->()){
  if Thread.isMainThread{
      block()
  }else{
    DispatchQueue.main.async(execute: block)
  }
}

@available(*, deprecated, renamed: "ui")
public func bx_runInMainThread(_ block:@escaping ()->()){
  if Thread.isMainThread{
    block()
  }else{
    DispatchQueue.main.async(execute: block)
  }
}


/// 延迟执行, 默认是在主线程中执行.
public func delay(_ interval:DispatchTimeInterval,on queue:DispatchQueue = .main, execute: @escaping () -> Void){
  queue.asyncAfter(deadline: .now() + interval, execute: execute)
}

@available(*,deprecated, renamed: "delay")
public func bx_delay(_ seconds:TimeInterval,block:@escaping ()->()){
  DispatchQueue.main.asyncAfter( deadline: .now() + seconds , execute: block)
}


/// 一个简单的立即执行的闭包的函数
public func local(_ execute:() -> Void){
  execute()
}

@available(*,deprecated, renamed: "local")
public func bx_local(_ closure:() -> Void){
  closure()
}
