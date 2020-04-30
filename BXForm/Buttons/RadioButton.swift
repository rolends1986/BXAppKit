//
//  RadioButton.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 20/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import Foundation
import UIKit

final public class RadioButton: CompoundButton{

  @objc public dynamic var checkedImage :UIImage?{
    set{
      setImage(newValue, for: .selected)
    }get{
      return image(for: .selected)
    }
  }
  @objc public dynamic var uncheckedImage:UIImage?{
    set{
      setImage(newValue, for: .normal)
    }get{
      return image(for: .normal)
    }
  }


}
