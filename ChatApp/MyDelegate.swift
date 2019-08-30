//
//  MyDelegate.swift
//  ChatApp
//
//  Created by Anil Kumar on 13/09/18.
//  Copyright © 2018 Anil Kumar. All rights reserved.
//

import UIKit
import MaterialComponents
class MyDelegate: NSObject ,MDCInkTouchControllerDelegate{
    
    func inkTouchController(_ inkTouchController: MDCInkTouchController, shouldProcessInkTouchesAtTouchLocation location: CGPoint) -> Bool {
        return true
    }

}
