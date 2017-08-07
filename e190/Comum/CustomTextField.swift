//
//  CustomTextField.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 25/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit
import SwiftMaskText

class CustomTextField {
    
    func removeMascara(text:SwiftMaskField, mascara: String) -> String
    {
        if let textRecuperado = text.text {
            return text.removeMaskCharacters(text: textRecuperado, withMask: mascara)
        }
        
        return ""
    }
}


