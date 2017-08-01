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
    
    
    func reenviarToken(codLogin:Int,completionHandler: ((NSDictionary) -> ())?) {
        
        //        @POST("api/usuario/reenviartoken")
        //        Call<tb_usuario> ReenviarToken(@Query("codLogin") long codLogin);
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/reenviartoken?codLogin=\(codLogin)"
        
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
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
    
    func ativarUsuario(parametros: [String:Any], completionHandler: ((NSDictionary) -> ())?) {

        guard let codlogin = parametros["codLogin"] as? Int, let codUsuario = parametros["codUsuario"] as? Int, let token = parametros["token"] as? String else
        {
            return
        }
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/ValidarToken?codLogin=\(codlogin)&codUsuario=\(codUsuario)&token=\(token)"
        
        var objUser: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
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

