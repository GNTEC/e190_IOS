//
//  customImageView.swift
//  e190
//
//  Created by User on 10/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit


@IBDesignable
class customImageView: UIImageView {

    @IBInspectable
    var radio: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radio
        }
    }
    
    @IBInspectable
    var masktoBounds: Bool = false{
        didSet {
            layer.masksToBounds = masktoBounds
        }
    }
}
