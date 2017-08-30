//  File.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Date {
  
  // MARK:  NSDate Manipulation
  

  // MARK:  Date comparison
  
  /**
  Checks if self is after input NSDate
  
  :param: date NSDate to compare
  :returns: True if self is after the input NSDate, false otherwise
  */
  public func isAfter(_ date: Date) -> Bool{
    return self > date
  }
  
  /**
   Checks if self is before input NSDate
   
   :param: date NSDate to compare
   :returns: True if self is before the input NSDate, false otherwise
   */
  public func isBefore(_ date: Date) -> Bool{
    return self < date
  }
  
  
  // MARK: Getter
  
  /**
  Date year
  */
  public var year : Int {
    get {
      return getComponent(.year)
    }
  }
  
  /**
   Date month
   */
  public var month : Int {
    get {
      return getComponent(.month)
    }
  }
  
  /**
   Date weekday
   */
  public var weekday : Int {
    get {
      return getComponent(.weekday)
    }
  }
  
  /**
   Date weekMonth
   */
  public var weekMonth : Int {
    get {
      return getComponent(.weekOfMonth)
    }
  }
  
  
  /**
   Date days
   */
  public var days : Int {
    get {
      return getComponent(.day)
    }
  }
  
  /**
   Date hours
   */
  public var hours : Int {
    
    get {
      return getComponent(.hour)
    }
  }
  
  /**
   Date minuts
   */
  public var minutes : Int {
    get {
      return getComponent(.minute)
    }
  }
  
  /**
   Date seconds
   */
  public var seconds : Int {
    get {
      return getComponent(.second)
    }
  }
  
  /**
   Returns the value of the NSDate component
   
   :param: component NSCalendarUnit
   :returns: the value of the component
   */
  
  public func getComponent (_ component : Calendar.Component) -> Int {
    let calendar = Calendar.current
    return calendar.component(component, from:self)
  }
}


func -(date: Date, otherDate: Date) -> TimeInterval {
  return date.timeIntervalSince(otherDate)
}



extension Date{
  public var bx_shortDateString:String{
    return bx_dateTimeStringWithFormatStyle(.short, timeStyle: .none)
  }
  
  public var bx_longDateString:String{
    return bx_dateTimeStringWithFormatStyle(.medium, timeStyle: .none)
  }
  
  public var bx_shortTimeString:String{
    return bx_dateTimeStringWithFormatStyle(.none, timeStyle: .short)
  }
  
  public var bx_dateTimeString:String{
    return bx_dateTimeStringWithFormatStyle(.medium, timeStyle: .medium)
  }

  public var bx_shortDateTimeString:String{
    return bx_dateTimeStringWithFormatStyle(.short, timeStyle: .short)
  }
  

  public func bx_dateTimeStringWithFormatStyle(_ dateStyle:DateFormatter.Style,timeStyle:DateFormatter.Style) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle
    dateFormatter.timeStyle = timeStyle
    return dateFormatter.string(from: self)
  }
  
  public var bx_relativeDateTimeString:String{
    let secondsToNow = abs(Int(timeIntervalSinceNow))
    let now = Date()
    let calendar = Calendar.current
    switch secondsToNow{
    case 0..<60: return i18n("刚刚")
    case 60..<300:
      return str(i18n("%d分钟前"),secondsToNow / 60)
    default:
      if calendar.isDateInYesterday(self){
        return i18n("昨天") + " " + bx_shortTimeString
      }else if calendar.isDateInToday(self){
        return bx_shortTimeString
      }else if now.year == year{
        return bx_shortDateString
      }else{
        return self.bx_longDateString
      }
    }
    
  }
}
