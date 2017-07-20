//
//  ApiLogin.swift
//  e190
//
//  Created by User on 15/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ApiLogin {

    func login(usuario: [String:Any], completionHandler: ((NSDictionary) -> ())?) {
     
        let urlString = "http://sekron.azurewebsites.net/api/login/logar"
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:usuario,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objUser = (result as? NSDictionary)!
                    print(objUser as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objUser = (result as? NSDictionary)!
                        print(objUser as Any)
                    }
                    
                    break
                }
            }
            
            DispatchQueue.main.async(execute: {
                completionHandler?(objUser)
            })
        }
    }
}
