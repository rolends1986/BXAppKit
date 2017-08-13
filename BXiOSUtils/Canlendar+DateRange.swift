
public extension Calendar{
  public func startDateInMonth(ofDate date:Date) -> Date{
    var comps = dateComponents([.year,.month,.day], from: date)
    comps.day = 1
    comps.hour = 0
    return self.date(from: comps)!
  }
  
  public func endDateInMonth(ofDate date:Date) -> Date{
    var comps = dateComponents([.year,.month,.day], from: date)
    let maxDay = self.range(of: .day, in: .month, for: date)!.count
    comps.day = maxDay
    comps.hour = 24
    return self.date(from: comps)!
  }
  
  public func startDay(ofDate date:Date) -> Date{
    var comps = dateComponents([.year,.month,.day], from: date)
    comps.hour = 0
    return self.date(from: comps)!
  }
  
  public func endDay(ofDate date:Date) -> Date{
    var comps = dateComponents([.year,.month,.day], from: date)
    comps.hour = 24
    return self.date(from: comps)!
  }
  
  public func mondayInWeek(_ date:Date) -> Date{
    var comps = dateComponents([.year,.weekOfYear,.weekday], from: date)
    comps.weekday = 2 // monday
    return self.date(from: comps)!
  }
  
  public func sundayInWeek(_ date:Date, mondayAsFirstDay : Bool = true) -> Date{
    var comps = dateComponents([.year,.weekOfYear,.weekday], from: date)
    comps.weekday = 1 // monday
    if mondayAsFirstDay{
      comps.weekOfYear = comps.weekOfYear! + 1
    }
    comps.hour = 24
    return self.date(from: comps)!
  }
  
  public func nextMonth(ofDate date:Date) -> Date{
    return self.date(byAdding: .month, value: 1, to: date)!
  }
  
  public func prevMonth(ofDate date:Date) -> Date{
    return self.date(byAdding: .month, value: -1, to: date)!
  }
  
  public func prevWeek(ofDate date:Date) -> Date{
    return self.date(byAdding: .weekOfYear, value: -1, to: date)!
  }
  
  
}
