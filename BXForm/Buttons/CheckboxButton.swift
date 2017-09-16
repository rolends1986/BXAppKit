//
//  CheckboxButton.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/9/24.
//

import UIKit

open class CheckboxButton: CompoundButton {
  @objc open dynamic var checkedImage :UIImage?{
    set{
      setImage(newValue, for: .selected)
    }get{
      return image(for: .selected)
    }
  }
  @objc open dynamic var uncheckedImage:UIImage?{
    set{
      setImage(newValue, for: .normal)
    }get{
      return image(for: .normal)
    }
  }

  
}
