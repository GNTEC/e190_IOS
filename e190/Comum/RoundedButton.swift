//
//  RoundedButton.swift
//  e190
//
//  Created by User on 12/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var radio: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radio
            layer.borderWidth = 1
        }
    }
    
    @IBInspectable
    var masktoBounds: Bool = false{
        didSet {
            layer.masksToBounds = masktoBounds
        }
    }
}
