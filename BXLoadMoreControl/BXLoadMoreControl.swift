//
//  BXLoadMoreControl.swift
//
//  Created by Haizhen Lee on 15/6/19.
//

import UIKit
import PinAuto
import BXiOSUtils

public struct BXLoadMoreSettings{
  public static var pullingString = i18n("上拉加载更多")
  public static var pulledString = i18n("释放加载更多")
  public static var loadingString = i18n("正在加载…")
  public static var loadedString = i18n("加载完成")
  public static var loadFailedString = i18n("加载失败")
  public static var nomoreString = i18n("没有更多了")
  public static var triggerPullDistance:CGFloat = 80
  public static var titleColor = UIColor(white: 0.333, alpha: 1.0)
  public static var titleFont = UIFont.systemFont(ofSize: 15)
  public static var backgroundColor = UIColor(white: 0.05, alpha: 1.0)
}

public enum BXLoadMoreState:Int{
    case preparing
    case pulling
    case pulled
    case loading
    case loaded
    case loadFailed
    case nomore
    
    public var tipLabel:String{
        if self == .pulling || self == .preparing{
            return BXLoadMoreSettings.pullingString
        }else if self == .pulled{
            return BXLoadMoreSettings.pulledString
        }else if self == .loading{
            return BXLoadMoreSettings.loadingString
        }else if self == .loaded{
            return  BXLoadMoreSettings.loadedString
        }else if self == .loadFailed{
            return BXLoadMoreSettings.loadFailedString
        }else if self == .nomore{
          return BXLoadMoreSettings.nomoreString
        }
        return ""
    }
}

open class BXLoadMoreControl: UIControl{

    
    fileprivate var loadMoreState = BXLoadMoreState.preparing
    
    public let titleLabel  = UILabel(frame: CGRect.zero)
    var controlHelper:BXLoadMoreControlHelper? // retain reference to Helper
    public let activityIndicator = UIActivityIndicatorView(style: .white)
   
    open  var onLoadingHandler: ( () -> Void)?
    
    /* The designated initializer
    * This initializes a UIRefreshControl with a default height and width.
    * Once assigned to a UITableViewController, the frame of the control is managed automatically.
    * When a user has pulled-to-refresh, the UIRefreshControl fires its UIControlEventValueChanged event.
    *
    */
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        backgroundColor = BXLoadMoreSettings.backgroundColor
        addSubview(titleLabel)
        addSubview(activityIndicator)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = BXLoadMoreSettings.titleFont
        titleLabel.textColor = BXLoadMoreSettings.titleColor
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = tintColor
        activityIndicator.pa_centerY.install()
        titleLabel.pac_center()
        activityIndicator.pa_before(titleLabel, offset: 8).install()
      // 初始默认不显示
        isHidden = true
      
    }
  
  open override func tintColorDidChange() {
    super.tintColorDidChange()
    activityIndicator.tintColor = tintColor
  }


    fileprivate func transitionToState(_ loadMoreState:BXLoadMoreState){
        self.loadMoreState = loadMoreState
        if loadMoreState == .loading{
            activityIndicator.startAnimating()
        }else{
           activityIndicator.stopAnimating()
        }
        titleLabel.text = loadMoreState.tipLabel
    }
    
    open var isPulling: Bool{ return loadMoreState == .pulling }
    open var isPulled: Bool{ return loadMoreState == .pulled }
    open var isPreparing: Bool{ return loadMoreState == .preparing }
    open var isLoading: Bool{ return loadMoreState == .loading }
    open var isNomore: Bool{ return loadMoreState == .nomore }
   
    open func startPull(){
       transitionToState(.pulling)
    }
    
    
    open func pulled(){
        transitionToState(.pulled)
    }
  
  open func nomore(_ shouldShow:Bool = true){
      transitionToState(.nomore)
      if !shouldShow{
        UIView.animate(withDuration: 0.25, animations: {
          self.isHidden = true
        })
      }
    }
  
    open func reset(){
        transitionToState(.preparing)
    }
    
    
    open func canceled(){
        transitionToState(.preparing)
    }
    
    open func startLoad(){
        transitionToState(.loading)
        sendActions(for: UIControl.Event.valueChanged)
        self.onLoadingHandler?()
    }
    
    open func loaded(){
        transitionToState(.loaded)
        self.prepareForNextPull()
    }
   
    fileprivate func prepareForNextPull(){
        delay(2){[weak self] in
            self?.transitionToState(.preparing)
        }
    }
    
    open func loadFailed(){
        transitionToState(.loadFailed)
        self.prepareForNextPull()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delay(_ seconds:TimeInterval, block:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds,execute: block)
    }
}

// Behavior lik UIRefreshControl
extension BXLoadMoreControl{

    
    public var loading: Bool {
        return isLoading
    }
  
    
    public var attributedTitle: NSAttributedString?{
        get{
            return titleLabel.attributedText
        }set{
            titleLabel.attributedText = newValue
        }
    }
    
    // May be used to indicate to the refreshControl that an external event has initiated the load action
    public func beginLoading(){
        startLoad()
    }
    // Must be explicitly called when the loading has completed
    public func endLoading(){
        loaded()
    }
}
