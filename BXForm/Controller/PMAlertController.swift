//
//  PMAlertController.swift
//  PMAlertController
//
//  Created by Paolo Musolino on 07/05/16.
//  Copyright © 2016 Codeido. All rights reserved.
//

import UIKit

 public enum PMAlertControllerStyle : Int {
    case alert // The alert will adopt a width of 270 (like UIAlertController).
    case walkthrough //The alert will adopt a width of the screen size minus 18 (from the left and right side). This style is designed to accommodate localization, push notifications and more.
}

open class PMAlertController: UIViewController {
    
    // MARK: Properties
  open let alertMaskBackground = UIImageView(frame: .zero)
  open let alertView = UIView(frame: .zero)
  open let contentStackView = UIStackView(frame: .zero)

  open let headerStackView = UIStackView(frame: .zero)
  open let titleLabel  = UILabel(frame:.zero)
  open let descriptionLabel = UILabel(frame: .zero)
  open let formStackView = UIStackView(frame: .zero)
  open let actionStackView = UIStackView(frame: .zero)

    var alertViewHeightConstraint: NSLayoutConstraint?
  var alertViewWidthConstraint: NSLayoutConstraint!
    var animator : UIDynamicAnimator?
    
    open var textFields: [UITextField] = []
    
    open var gravityDismissAnimation = true
    open var dismissWithBackgroudTouch = false // enable touch background to dismiss. Off by default.
    
    //MARK: - Lifecycle
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    //MARK: - Initialiser
    public  init(title: String?, message: String?, preferredStyle: PMAlertControllerStyle) {
      super.init(nibName: nil, bundle: nil)

        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        titleLabel.text = title
        descriptionLabel.text = message

    }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("Not Supported")
  }

  func installConstraints() {
    alertMaskBackground.pac_edge(top: 0, left: 0, bottom: 0, right: 0)
    alertView.pa_centerX.install()
    alertView.pa_centerY.install()
    alertViewWidthConstraint = alertView.pa_width.eq(270).install()
    alertViewHeightConstraint = alertView.pa_height.eq(140).install()
    contentStackView.pac_edge(top: 30, left: 16, bottom: 30, right: 16 )
  }

  func setupAttrs()  {

    setShadowAlertView()

    alertMaskBackground.backgroundColor = UIColor(white: 0.0, alpha:0.7)

    alertView.layer.cornerRadius = 4
    alertView.clipsToBounds = true
    alertView.backgroundColor = UIColor(hex: 0x333333)

    titleLabel.textColor = FormColors.primaryTextColor
    titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    titleLabel.numberOfLines = 2

    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
    descriptionLabel.textColor = FormColors.secondaryTextColor
    descriptionLabel.numberOfLines = 0


    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .equalSpacing
    contentStackView.spacing = 15

    headerStackView.axis = .vertical
    headerStackView.alignment = .center
    headerStackView.distribution = .equalSpacing
    headerStackView.spacing = 8

    formStackView.axis = .vertical
    formStackView.alignment = .fill
    formStackView.distribution = .equalSpacing
    formStackView.spacing = 8

    actionStackView.alignment = .center
    actionStackView.distribution = .fillEqually
    actionStackView.spacing = 20
    actionStackView.axis = .horizontal

  }


  func commonInit() {
    for childView in [alertMaskBackground, alertView, contentStackView]{
      view.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }

    alertView.addSubview(contentStackView)
    contentStackView.translatesAutoresizingMaskIntoConstraints = false

    contentStackView.addArrangedSubviews([headerStackView, formStackView, actionStackView])
    

    let noTitle = titleLabel.text?.isEmpty ?? true
    if !noTitle{
      headerStackView.addArrangedSubview(titleLabel)
    }
    let noDescription = descriptionLabel.text?.isEmpty ?? true
    if !noDescription{
      headerStackView.addArrangedSubview(descriptionLabel)
    }

    installConstraints()
    setupAttrs()


  }



  open override func loadView() {
    super.loadView()
    view.backgroundColor = .clear
    commonInit()
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    //Gesture recognizer for background dismiss with background touch
    let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissAlertControllerFromBackgroundTap))
    alertMaskBackground.addGestureRecognizer(tapRecognizer)
  }
    
    //MARK: - Actions
    @objc open func addAction(_ alertAction: PMAlertAction){
        actionStackView.addArrangedSubview(alertAction)
        
        if actionStackView.arrangedSubviews.count > 2{
            actionStackView.axis = .vertical
        }else{
            actionStackView.axis = .horizontal
        }
        updateAlertViewHeight()
        alertAction.addTarget(self, action: #selector(PMAlertController.dismissAlertController(_:)), for: .touchUpInside)
        
    }

  private func updateAlertViewHeight(){
    alertViewHeightConstraint?.isActive = false
    let size = alertView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    alertViewHeightConstraint?.constant = size.height
    alertViewHeightConstraint?.isActive = true
  }
    
    @objc fileprivate func dismissAlertController(_ sender: PMAlertAction){
        self.animateDismissWithGravity(sender.actionStyle)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func dismissAlertControllerFromBackgroundTap() {
        if !dismissWithBackgroudTouch {
            return
        }
        
        self.animateDismissWithGravity(.cancel)
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - Text Fields
    @objc open func addTextField(_ configuration: (_ textField: UITextField) -> Void){
        let textField = UITextField()
       let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        textField.addConstraint(heightConstraint)
        textField.delegate = self
        textField.returnKeyType = .done
        textField.font =  UIFont.systemFont(ofSize: 13, weight: .medium)
        textField.textAlignment = .center
        configuration (textField)
        _addTextField(textField)
    }


    func _addTextField(_ textField: UITextField){
        formStackView.addArrangedSubview(textField)
        textFields.append(textField)

       updateAlertViewHeight()
    }
    
    func hasTextFieldAdded () -> Bool{
        return textFields.count > 0
    }
    
    //MARK: - Customizations
    @objc fileprivate func setShadowAlertView(){
        alertView.layer.masksToBounds = false
        alertView.layer.shadowOffset = CGSize(width: 0, height: 0)
        alertView.layer.shadowRadius = 8
        alertView.layer.shadowOpacity = 0.3
    }
    
    //MARK: - Animations
    
  fileprivate func animateDismissWithGravity(_ style: PMAlertActionStyle){
        if gravityDismissAnimation == true{
            var radian = Double.pi
            if style == .default {
                radian = 2 * Double.pi
            }else{
                radian = -2 * Double.pi
            }
            animator = UIDynamicAnimator(referenceView: self.view)
            
            let gravityBehavior = UIGravityBehavior(items: [alertView])
            gravityBehavior.gravityDirection = CGVector(dx: 0, dy: 10)
            
            animator?.addBehavior(gravityBehavior)
            
            let itemBehavior = UIDynamicItemBehavior(items: [alertView])
            itemBehavior.addAngularVelocity(CGFloat(radian), for: alertView)
            animator?.addBehavior(itemBehavior)
        }
    }
    
    //MARK: - Keyboard avoiding
    
    var tempFrameOrigin: CGPoint?
    var keyboardHasBeenShown:Bool = false
    
    @objc func keyboardWillShow(_ notification: Notification) {
        keyboardHasBeenShown = true
        
        guard let userInfo = (notification as NSNotification).userInfo else {return}
        guard let endKeyBoardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.minY else {return}
        
        if tempFrameOrigin == nil {
            tempFrameOrigin = alertView.frame.origin
        }
        
        var newContentViewFrameY = alertView.frame.maxY - endKeyBoardFrame
        if newContentViewFrameY < 0 {
            newContentViewFrameY = 0
        }
        alertView.frame.origin.y -= newContentViewFrameY
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if (keyboardHasBeenShown) { // Only on the simulator (keyboard will be hidden)
            if (tempFrameOrigin != nil){
                alertView.frame.origin.y = tempFrameOrigin!.y
                tempFrameOrigin = nil
            }
            
            keyboardHasBeenShown = false
        }
    }
}

extension PMAlertController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
