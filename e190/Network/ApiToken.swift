//
//  ApiToken.swift
//  e190
//
//  Created by Marcelo Pavani on 20/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ApiToken {


//    @POST("api/usuario/ValidarToken")
//    Call<tb_usuario> ValidarToken(@Query("codLogin") long codLogin,
//    @Query("codUsuario") long codUsuario,
//    @Query("token") String token);
    
    
    func reenviarToken() {
        
        
        
    }
    
    func ativarUsuario(parametros: [String:Any], completionHandler: ((NSDictionary) -> ())?) {
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/ValidarToken"
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:parametros,encoding: JSONEncoding.default, headers: nil).responseJSON {
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

