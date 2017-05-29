//
//  EsqueciASenha.swift
//  e190
//
//  Created by Marcelo Pavani on 29/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import Alamofire

class EsqueciASenha {
    
    func SolicitaSenhaNova (email: String )-> String {
    
        var strMessegeRet: String =  ""
        var result: String = ""
        
//        let parametros = [
//            
//            "email": email
//        ]
        
        let urlString = "http://sekron.azurewebsites.net/api/redefinirsenha/redefinirSenha?email=" + email
        
        Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    if result == response.result.description {
                        
                        //let msgRet = result as? NSDictionary
                        //strMessegeRet = msgRet?["Message"] as! String
                        strMessegeRet = result
                        
                    }
                    
                default:
                    
                    if result == response.result.description {
                        
                        //let msgRet = result as? NSDictionary
                        //strMessegeRet = msgRet?["Message"] as! String
                        strMessegeRet = result
                    }
                    
                    break
                    
                }
            }
        }
        
        return strMessegeRet
    }
}
