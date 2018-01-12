import UIKit
import PinAuto

/**
 * Displays a simple HUD window containing a progress indicator and two optional labels for short messages.
 *
 * This is a simple drop-in class for displaying a progress HUD view similar to Apple's private UIProgressHUD class.
 * The BXProgressHUD window spans over the entire space given to it by the initWithFrame constructor and catches all
 * user input on this region, thereby preventing the user operations on components below the view. The HUD itself is
 * drawn centered as a rounded semi-transparent view which resizes depending on the user specified content.
 *
 * This view supports four modes of operation:
 * - BXProgressHUDModeIndeterminate - shows a UIActivityIndicatorView
 * - BXProgressHUDModeDeterminate - shows a custom round progress indicator
 * - BXProgressHUDModeAnnularDeterminate - shows a custom annular progress indicator
 * - BXProgressHUDModeCustomView - shows an arbitrary, user specified view (@see customView)
 *
 * All three modes can have optional labels assigned:
 * - If the labelText property is set and non-empty then a label containing the provided content is placed below the
 *   indicator view.
 * - If also the detailsLabelText property is set then another label is placed below the first label.
 */
open class BXProgressHUD : UIView {
  /**
   * A block that gets called after the HUD was completely hidden.
   */
  open var completionBlock: BXProgressHUDCompletionBlock?
  
  /**
   * BXProgressHUD operation mode. The default is BXProgressHUDModeIndeterminate.
   *
   * @see BXProgressHUDMode
   */
  open var mode: BXProgressHUDMode = .indeterminate{
    didSet{
      onModeChanged()
    }
  }
  
  /**
   * The animation type that should be used when the HUD is shown and hidden.
   *
   * @see BXProgressHUDAnimation
   */
  open var animationType: BXProgressHUDAnimation  = .fade
  
  
  /**
   * The UIView (e.g., a UIImageView) to be shown when the HUD is in BXProgressHUDModeCustomView.
   * For best results use a 37 by 37 pixel view (so the bounds match the built in indicator bounds).
   */
  open var customView: UIView?
  
  /**
   * The HUD delegate object.
   *
   * @see BXProgressHUDDelegate
   */
  weak open var delegate: BXProgressHUDDelegate?
  


  
  /**
   * The x-axis offset of the HUD relative to the centre of the superview.
   */
  open var xOffset: CGFloat = 0.0
  
  /**
   * The y-axis offset of the HUD relative to the centre of the superview.
   */
  open var yOffset: CGFloat = 0.0
  
  /**
   * The amount of space between the HUD edge and the HUD elements (labels, indicators or custom views).
   * Defaults to 24.0
   */
  open var margin: CGFloat = 24.0{
    didSet{

    }
  }
  
  /**
   * The corner radius for the HUD
   * Defaults to 10.0
   */
  open var cornerRadius: CGFloat = 10{
    didSet{
      backgroundView.layer.cornerRadius = cornerRadius
      backgroundView.clipsToBounds = true
    }
  }
  
  /**
   * Cover the HUD background view with a radial gradient.
   */
  open var dimBackground: Bool = false
  
  /*
  * Grace period is the time (in seconds) that the invoked method may be run without
  * showing the HUD. If the task finishes before the grace time runs out, the HUD will
  * not be shown at all.
  * This may be used to prevent HUD display for very short tasks.
  * Defaults to 0 (no grace time).
  * Grace time functionality is only supported when the task status is known!
  * @see taskInProgress
  */
  open var graceTime: TimeInterval = 0.0
  
  /**
   * The minimum time (in seconds) that the HUD is shown.
   * This avoids the problem of the HUD being shown and than instantly hidden.
   * Defaults to 0 (no minimum show time).
   */
  open var minShowTime: TimeInterval = 0.0
  
  /**
   * Indicates that the executed operation is in progress. Needed for correct graceTime operation.
   * If you don't set a graceTime (different than 0.0) this does nothing.
   * This property is automatically set when using showWhileExecuting:onTarget:withObject:animated:.
   * When threading is done outside of the HUD (i.e., when the show: and hide: methods are used directly),
   * you need to set this property when your task starts and completes in order to have normal graceTime
   * functionality.
   */
  open var taskInProgress: Bool = false
  
  /**
   * Removes the HUD from its parent view when hidden.
   * Defaults to NO.
   */
  open var removeFromSuperViewOnHide: Bool = false
  public let backgroundView  = UIView(frame:.zero) //:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
  let contentStackView = UIStackView(arrangedSubviews: [])

  /**
   * 以下几个基本元素
   */
  public let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  public let checkmarkImageView = UIImageView(image: nil)
  public let barProgressView = BXBarProgressView()
  public let roundProgressView =  BXRoundProgressView()
  public let label :UILabel =  UILabel(frame: CGRect.zero)
  public let detailsLabel :UILabel =  UILabel(frame: CGRect.zero)
 
  public var checkmarkImage:UIImage?{
    set{
      checkmarkImageView.image = newValue
      checkmarkImageView.sizeToFit()
    }get{
      return checkmarkImageView.image
    }
  }

//  open var blurStyle : UIBlurEffectStyle = .dark{
//    didSet{
//      backgroundView.effect = UIBlurEffect(style: blurStyle)
//    }
//  }

  
  /**
   * The progress of the progress indicator, from 0.0 to 1.0. Defaults to 0.0.
   */
  open var progress: CGFloat = 1.0{
    didSet{
        barProgressView.progress = progress
        roundProgressView.progress = progress
    }
  }


  /**
   * Force the HUD dimensions to be equal if possible.
   */
  open var square: Bool = false
  
  var useAnimation = false
  
  var isFinished = false
  var rotationTransform = CGAffineTransform.identity
  
  var showStarted:Date?
  

  
  public init(){
    super.init(frame: UIScreen.main.bounds)
    commonInit()

  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func commonInit(){
    // Transparent background
    backgroundColor = .clear
    isOpaque = false
    // Make it invisible for now
    alpha = 0.0
    addSubview(backgroundView)
    addSubview(contentStackView)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    contentStackView.translatesAutoresizingMaskIntoConstraints = false
    setupAttrs()
    installConstraints()
    registerForNotifications()
    onModeChanged()
  }

  func setupAttrs(){
    contentStackView.alignment = .center
    contentStackView.distribution = .equalSpacing
    contentStackView.axis = .vertical
    contentStackView.spacing = 8

    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: BXProgressOptions.labelFontSize, weight: .medium)
    label.numberOfLines = 2

    detailsLabel.textColor = .white
    detailsLabel.numberOfLines = 2
    detailsLabel.font = UIFont.systemFont(ofSize: BXProgressOptions.detailsLabelFontSize)


    for l in [label,detailsLabel]{
      l.adjustsFontSizeToFitWidth = false
      l.textAlignment = .center
      l.isOpaque = false
      l.backgroundColor = .clear
    }
    if cornerRadius > 0.1{
      // see http://stackoverflow.com/questions/29029335/corner-radius-on-uivisualeffectview
      let blurView = backgroundView
      blurView.layer.cornerRadius = cornerRadius
      blurView.clipsToBounds = true
    }

  }


  var contentWidthConstraint:NSLayoutConstraint?
  var contentHeightConstraint:NSLayoutConstraint?

  func installConstraints(){
    contentStackView.pa_centerX.offset(xOffset).install()
    contentStackView.pa_centerY.offset(yOffset).install()
    contentWidthConstraint = contentStackView.pa_width.eq(56).install()
    contentHeightConstraint = contentStackView.pa_height.eq(56).install()

    backgroundView.pa_centerX.eqTo(contentStackView).install()
    backgroundView.pa_centerY.eqTo(contentStackView).install()
    backgroundView.pa_width.eqTo(contentStackView).offset(margin * 2).install()
    backgroundView.pa_height.eqTo(contentStackView).offset(margin * 2).install()
  }

  func onModeChanged(){
    let oldViews = contentStackView.arrangedSubviews
    for oldView in oldViews{
      contentStackView.removeArrangedSubview(oldView)
      oldView.removeFromSuperview()
    }
    activityIndicatorView.stopAnimating()
    switch mode{
    case .indeterminate:
      contentStackView.addArrangedSubview(activityIndicatorView)
      activityIndicatorView.startAnimating()
    case .checkmark:
      contentStackView.addArrangedSubview(checkmarkImageView)
    case .determinateHorizontalBar:
      contentStackView.addArrangedSubview(barProgressView)
    case .annularDeterminate,.determinate:
      roundProgressView.annular = mode == .annularDeterminate
      contentStackView.addArrangedSubview(roundProgressView)
    case .customView:
      if let customView = customView{
        contentStackView.addArrangedSubview(customView)
      }
    case .text:
      break
    }
    contentStackView.addArrangedSubview(label)
    contentStackView.addArrangedSubview(detailsLabel)

    let minSpacing :CGFloat = margin * 2  + 15 * 2
    let maxWidth = bounds.width - minSpacing
    let maxHeight = bounds.height - minSpacing
    contentWidthConstraint?.isActive = false
    contentHeightConstraint?.isActive = false
    var size = contentStackView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    if size.width > maxWidth{
        // 如果会超过宽度,限定最大宽度,然后再次测量
        contentWidthConstraint?.constant =  maxWidth
        contentWidthConstraint?.isActive = true
        size = contentStackView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    contentWidthConstraint?.constant = min(size.width, maxWidth)
    contentHeightConstraint?.constant = min(size.height, maxHeight)
    contentWidthConstraint?.isActive = true
    contentHeightConstraint?.isActive = true

  }



  
  open func attachTo(_ view:UIView){
    self.removeFromSuperview()
    frame = view.bounds
    view.addSubview(self)
  }
 
  @nonobjc
  open func attachTo(_ window:UIWindow){
    self.attachTo(window as UIView)
  }
  

  open override func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    #if DEBUG
      NSLog("\(#function)")
    #endif
    if let superView  = newSuperview{
      frame = superView.bounds
    }
  }
  
 
  func imageByName(_ name:String) -> UIImage?{
    let bundleOfThis = Bundle(for: BXProgressHUD.self)
    guard let bundleURL = bundleOfThis.url(forResource: "BXProgressHUD", withExtension: "bundle") else{
      NSLog("Resources bundle not found")
      return nil
    }
    
    guard let bundle = Bundle(url: bundleURL) else{
      NSLog("Could not load Resources Bundle \(bundleURL)")
      return nil
    }
    if let imagePath = bundle.path(forResource: name, ofType: "png"){
      return UIImage(contentsOfFile: imagePath)
    }else{
      return nil
    }
    
  }
  
  deinit{
    NotificationCenter.default.removeObserver(self)
  }
  
  
}



extension BXProgressHUD{
  
  
  
  
}



extension BXProgressHUD{
  
  public static func showHUDAddedTo(_ view:UIView, animated:Bool = true) -> BXProgressHUD{
    let hud = BXProgressHUD()
    hud.removeFromSuperViewOnHide = true
    view.addSubview(hud)
    hud.show(animated)
    return hud
  }
  
  public static func HUDForView(_ view:UIView) -> BXProgressHUD? {
    return view.subviews.reversed().filter{ $0 is BXProgressHUD }.first as? BXProgressHUD
  }
  
  public static func allHUDsForView(_ view:UIView) -> [BXProgressHUD]{
    var huds = [BXProgressHUD]()
    view.subviews.forEach{ subview in
      if let hud = subview as? BXProgressHUD{
        huds.append(hud)
      }
    }
    return huds
  }
  
  public static func hideHUDForView(_ view:UIView,animated:Bool = true) -> Bool{
    if let hud = HUDForView(view){
      hud.removeFromSuperViewOnHide = true
      hud.hide()
      return true
    }else{
      return false
    }
  }
  
  public static func hideAllHUDsForView(_ view:UIView, animated:Bool = true) -> Int {
    let huds = allHUDsForView(view)
    huds.forEach{ hud in
      hud.removeFromSuperViewOnHide = true
      hud.hide(animated)
    }
    return huds.count
  }
}

extension BXProgressHUD{
  // MARK: Thread  block
  public func showAnimated(_ animated:Bool,
    whileExecutingBlock block:@escaping ()->(),
    onQueue queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default),
    completionBlock completion:BXProgressHUDCompletionBlock? = nil){
      taskInProgress = true
      completionBlock = completion
      queue.async{
        block()
        DispatchQueue.main.async{
          self.hide(animated)
          self.completionBlock = nil
        }
      }
      self.show(animated)
  }
  
  func delay(_ delay:TimeInterval,closure:@escaping ()-> Void){
    let when = DispatchTime.now() + Double(Int64(delay * TimeInterval(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: when , execute: closure)
  }
}

extension BXProgressHUD{
  
  func registerForNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil, queue: nil) { (notif) -> Void in
      if self.superview != nil{
        self.updateForCurrentOrientationAnimated()
      }
    }
  }
  
  func updateForCurrentOrientationAnimated(_ animated:Bool = true){
    if let superview = self.superview{
      if animated{
       UIView.animate(withDuration: 0.25){
          self.bounds = superview.bounds
       }
      }else{
        bounds = superview.bounds
      }
    }
  }
}

extension BXProgressHUD{
  open override func didMoveToSuperview() {
    super.didMoveToSuperview()
    updateForCurrentOrientationAnimated(false)
  }
  
  
}


extension BXProgressHUD{
  
  // MARK: Show & hide
  
  public func show(_ animated:Bool = true){
    useAnimation = animated
    if graceTime > 0.0{
      delay(graceTime){
        // Show the HUD only if the task is still running
        if self.taskInProgress{
          self.showUsingAnimation(self.useAnimation)
        }
      }
    }else{
      showUsingAnimation(useAnimation)
    }
  }
  
  public func hide(_ animated:Bool = true){
    useAnimation = animated
    // If the minShow time is set, calculate how long the hud shown
    // and pospone the hiding operation if necessary
    if let started = showStarted , minShowTime > 0.0{
      let interval = Date().timeIntervalSince(started)
      if interval < minShowTime{
        delay(minShowTime - interval){
          if self.taskInProgress{
            self.hideUsingAnimation(self.useAnimation)
          }
        }
        return
      }
      
    }else{
      hideUsingAnimation(animated)
    }
  }
  
  public func hide(_ animated:Bool = true,afterDelay seconds:TimeInterval){
    delay(seconds){
      self.hide(animated)
    }
  }
  
  
  
  // MARK: Internal show & hide operations
  
  func showUsingAnimation(_ animated:Bool){
    // Cancel any scheduled hideDeplayed: calls
    NSObject.cancelPreviousPerformRequests(withTarget: self)
    setNeedsDisplay()
    if animated{
      if animationType == .zoomIn{
        transform = rotationTransform.concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
      }else if animationType == .ZoomOut{
        transform = rotationTransform.concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
      }
    }
    showStarted = Date()
    
    if animated{
      UIView.beginAnimations(nil, context: nil)
      UIView.setAnimationDuration(0.3)
      self.alpha = 1.0
      if animationType == .zoomIn || animationType == .ZoomOut{
        self.transform = rotationTransform
      }
      UIView.commitAnimations()
    }else{
      self.alpha = 1.0
    }
    
  }
  
  func hideUsingAnimation(_ animated:Bool){
    if animated && showStarted != nil{
      UIView.animate(withDuration: 0.3, animations: {
        self.alpha = 0.02
        // 0.02 prevents the hud from passing through touches during the animation the hud will get completely hidden in the done method
        if self.animationType == .zoomIn{
          self.transform = self.rotationTransform.concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
        }else if self.animationType == .ZoomOut{
          self.transform = self.rotationTransform.concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
        }
        
        }, completion: { (finished) -> Void in
          if finished{ // since iOS 8 there is no need to check this
            self.done()
          }
      })
    }else{
      done()
    }
    
    showStarted = nil
  }
  
  func done(){
    NSObject.cancelPreviousPerformRequests(withTarget: self)
    isFinished = true
    alpha =  0.0
    setNeedsDisplay()
    completionBlock?()
    if removeFromSuperViewOnHide{
      removeFromSuperview()
      completionBlock = nil
    }else{
      superview?.sendSubview(toBack: self)
    }
    delegate?.hudWasHidden(self)
  }
  
}
