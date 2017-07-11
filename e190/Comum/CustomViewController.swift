//
//  CustomViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 29/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

@IBDesignable
class CustomViewController: UIView {
    
    @IBInspectable
    var radio: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radio
        }
    }
}
