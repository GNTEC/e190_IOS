//
//  ApiCasa+Trabalho.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 04/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ApiCasa_Trabalho
{
    func listar(codUsuario:Int, completationHandler:(([String:Any]) -> ())?)
    {
        let urlString = "http://sekron.azurewebsites.net/api/usuario/ListarUsuarioId?id=\(codUsuario)"
        
        var objReturn: [String:Any] = [:]
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? [String: Any])!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? [String:Any])!
                        print(objReturn as Any)
                    }
                    
                    break
                }
            }
            DispatchQueue.main.async(execute: {
                completationHandler?(objReturn)
            })
        }
    }
    
    func salvar(codUsuario:Int, cepCasa:String, enderecoCasa: String, cepTrabalho:String,enderecoTrabalho:String,  completionHandler: ((String) -> ())?) {
        
        var urlString = "http://sekron.azurewebsites.net/api/usuario/SalvarConfiguracoes?codUsuario=\(codUsuario)"
        
        let urlParameter: String = ("&cepCasa=\(cepCasa)&enderecoCasa=\(enderecoCasa)&cepTrabalho=\(cepTrabalho)&enderecoTrabalho=\(enderecoTrabalho)")
        
        let escapedString = urlParameter.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        urlString = urlString + escapedString!
    
        var objReturn: String = ""
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? String)!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? String)!
                        print(objReturn as Any)
                    }
                    
                    break
                }
            }
            DispatchQueue.main.async(execute: {
                completionHandler?(objReturn)
            })
        }
    }
}
