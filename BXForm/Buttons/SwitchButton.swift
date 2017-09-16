//
//  SwitchButton.swift
//  BXAppKit
//
//  Created by Haizhen Lee on 16/06/2017.
//  Copyright © 2017 banxi1988. All rights reserved.
//

import UIKit

final public class SwitchButton: CompoundButton{

  @objc open dynamic var onImage:UIImage?{
    get{ return image(for: .selected) }
    set{
      setImage(newValue, for: .selected)
    }
  }

  @objc open dynamic var offImage:UIImage?{
    get{ return image(for: .normal) }
    set{
      setImage(newValue, for: .normal)
    }
  }


}
