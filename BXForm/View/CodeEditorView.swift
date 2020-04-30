//
//  CodeEditorView.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 23/05/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation

public class CodeView:UILabel{
  public var size:CGSize = CGSize(width: 30, height: 30)

  public override var intrinsicContentSize: CGSize{
    return size
  }
}

import UIKit
import BXModel
import BXiOSUtils


open class CodeEditorView : UIView,UITextFieldDelegate{
  public let hiddenTextField = UITextField(frame:CGRect.zero)
  public let stackView = UIStackView(frame: .zero)
  public let codeCount:Int
  public let codeViews:[CodeView]

  public var codeViewSize:CGSize = CGSize(width: 40, height: 40){
    didSet{
      for codeView in codeViews{
        codeView.size = codeViewSize
      }
    }
  }

  public init(codeCount:Int=6){
    self.codeCount = codeCount
    self.codeViews = (1...codeCount).map{ _ in CodeView(frame:.zero) }
    for holder in self.codeViews{
      holder.backgroundColor = .white
      holder.textAlignment = .center
      holder.textColor = UIColor.darkText
      holder.clipsToBounds = true
      holder.size = codeViewSize
      holder.layer.cornerRadius = 4
      holder.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
      stackView.addArrangedSubview(holder)
    }
    stackView.spacing = 8
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    hiddenTextField.text = ""
    hiddenTextField.isHidden = true
    super.init(frame: CGRect.zero)
      

    commonInit()
  }



  var code:String{
    return hiddenTextField.text ?? ""
  }

  var allOutlets :[UIView]{
    return [hiddenTextField,stackView]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [hiddenTextField]
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("NotImplemented")
  }

  open func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()

  }

  open func installConstaints(){
    stackView.pac_edge(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

    hiddenTextField.pa_centerY.install()
    hiddenTextField.pa_centerX.install()
    hiddenTextField.pac_horizontal(0)
    hiddenTextField.pa_height.eq(36).install()

  }

  open func setupAttrs(){
    hiddenTextField.delegate = self
    hiddenTextField.keyboardType = .numberPad
    hiddenTextField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
    // hiddenTextField.isSecureTextEntry = true // 就算不可见也要设置,因为 UITextField 有全局广播通知
    stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    layer.cornerRadius = 4
    clipsToBounds = true
  }



  @objc func onTap(_ sender:AnyObject){
    hiddenTextField.becomeFirstResponder()
  }

  open override var canBecomeFirstResponder : Bool {
    return hiddenTextField.canBecomeFirstResponder
  }

  open override func becomeFirstResponder() -> Bool {
    return hiddenTextField.becomeFirstResponder()
  }

  open override func resignFirstResponder() -> Bool {
    return hiddenTextField.resignFirstResponder()
  }

  // MARK: UITextFieldDelegate

  func updateVisiblCode(){
    let chars = Array((hiddenTextField.text ?? ""))
    for (index,codeView) in codeViews.enumerated(){
      if index < chars.endIndex{
        codeView.text = String(chars[index])
      }else{
        codeView.text = nil
      }
    }
  }

  public func clear(){
    hiddenTextField.text = ""
    updateVisiblCode()
  }

  open var didInputAllCode:((String) -> Void)?

  @objc func onTextChanged(_ sender:AnyObject){
    updateVisiblCode()
    if code.count == codeCount{
      self.didInputAllCode?(code)
    }
  }

  open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let code = textField.text ?? ""
    let currentCount = code.count
    if range.length == 0 {
      // append
      return currentCount < codeCount
    }else{
      // delete
      return true
    }
  }

}
