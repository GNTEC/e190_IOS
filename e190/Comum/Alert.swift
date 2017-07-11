//
//  Alert.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 06/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class Alert
{
    func alertaSimples(titulo:String, mensagem: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        return alertController
    }
}
