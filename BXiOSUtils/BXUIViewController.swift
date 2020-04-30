//
//  BXUIViewController.swift
//  BXiOSUtils
//
//  Created by qinjilei on 2020/4/27.
//  Copyright © 2020 banxi1988. All rights reserved.
//

import Foundation
import UIKit

 
open class BXUIViewController: UIViewController {
    open override func loadView() {
        super.loadView()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
    }
}
