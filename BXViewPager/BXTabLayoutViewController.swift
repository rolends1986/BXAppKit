//
//  BXBaseTabViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/12.
//
//

import UIKit
import BXiOSUtils


open class BXTabLayoutViewController:BXUIViewController{
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public init(){
    super.init(nibName: nil, bundle: nil)
   
  }
  

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  open fileprivate(set) var viewControllers: [UIViewController] = []
  var initialPage = 0
  open func setViewControllers(_ viewControllers: [UIViewController], initialPage:Int = 0){
    self.initialPage = initialPage
    self.viewControllers = viewControllers
    updateTabs()
    if isViewLoaded{
      setupInitialViewController()
    }

  }
  
  
  open lazy fileprivate(set) var tabLayout : BXTabLayout = {
    let tabLayout = BXTabLayout()
    tabLayout.backgroundColor = UIColor.white
    return tabLayout
  }()
  
  public let containerView:UIView = UIView()
  
  
  open var didSelectedTab: ( (BXTab) -> Void )?
  
  open var showIndicator:Bool{
    get{
      return tabLayout.showIndicator
    }set{
      tabLayout.showIndicator = newValue
    }
  }
  
  
  func updateTabs(){
    if useCustomTabs{
      return
    }
    var tabs:[BXTab] = []
    for (index,vc) in self.viewControllers.enumerated() {
      let tab = BXTab(text: vc.title)
      tab.position = index
      tabs.append(tab)
    }
    tabLayout.updateTabs(tabs)
  }
 
  fileprivate var useCustomTabs = false
  open func updateTabs(_ tabs:[BXTab]){
    useCustomTabs = true
   tabLayout.updateTabs(tabs)
  }
 
  
  open var tabLayoutHeight:CGFloat{
    get{
      return tabLayoutHeightContraint?.constant ?? TabLayoutDefaultOptions.defaultHeight
    }set{
      tabLayoutHeightContraint?.constant = newValue
    }
  }
  
  open fileprivate(set) var tabLayoutHeightContraint:NSLayoutConstraint?
  open fileprivate(set) var tabLayoutLeadingConstraint:NSLayoutConstraint?
  open fileprivate(set) var tabLayoutTrailingConstraint:NSLayoutConstraint?
  
  open override func loadView() {
    super.loadView()
     self.automaticallyAdjustsScrollViewInsets = false
    tabLayout.registerClass(BXTabView.self)
    //
    self.view.addSubview(tabLayout)
    tabLayout.translatesAutoresizingMaskIntoConstraints = false
    tabLayout.pa_below(topLayoutGuide).install()
    tabLayoutLeadingConstraint =  tabLayout.pa_leading.eq(0).install()
    tabLayoutTrailingConstraint =  tabLayout.pa_trailing.eq(0).install()
    tabLayoutHeightContraint = tabLayout.pa_height.eq(TabLayoutDefaultOptions.defaultHeight).install()
    
    
    self.view.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.pac_horizontal(0)
    containerView.pa_below(tabLayout,offset:0).install()
    containerView.pa_above(bottomLayoutGuide).install()
    
    
    containerView.backgroundColor = UIColor.white
  }
  
  func addChildControllerToContainer(_ controller:UIViewController){
    addChild(controller)
    containerView.addSubview(controller.view)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.pac_edge(0)
    controller.didMove(toParent: self)
  }

  override open func viewDidLoad(){
    super.viewDidLoad()
    tabLayout.didSelectedTab = { [weak self]
      tab in
      self?.showPageAtIndex(tab.position)
    }
  
  }
  
//  func recalculateItemSize(){
//    tabLayout.updateItemSize()
//  }
  
  fileprivate var hasSelectAny = false
  
  func setupInitialViewController(){
    if hasSelectAny{
      return
    }
    hasSelectAny = true
    
    DispatchQueue.main.async {
        self.tabLayout.selectTabAtIndex(self.initialPage)
    }
    showPageAtIndex(initialPage)
  }
  

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    NSLog("\(#function)")
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NSLog("\(#function)")
    if viewControllers.count > 0 {
      setupInitialViewController()
    }
  }
  
  
  // MARK: Abstract Method
  open func currentPageIndex() -> Int?{
    guard let currentVC = currentPageViewController else{
      return nil
    }
    return  viewControllers.index(of: currentVC)
  }
  
  open func showPageAtIndex(_ index:Int){
    fatalError("Should Override this")
  }
  
  open var currentPageViewController:UIViewController?{
    fatalError("Should Override this")
  }
  
  
}
