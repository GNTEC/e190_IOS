//
//  ApiContato.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 01/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ApiContato
{
    func listar(codUsuario: Int, completionHandler: ((Array<AnyObject>) -> ())?) {
    
        let urlString = "http://sekron.azurewebsites.net/api/contato/listarcontatosusuario?id=\(codUsuario)"
        
        var objReturn: Array<AnyObject> = []
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? Array<AnyObject> )!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? Array<AnyObject> )!
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
    
    func salvar(parametros: [String:Any], completionHandler: ((NSDictionary) -> ())?) {
        
        let urlString = "http://sekron.azurewebsites.net/api/contato/novocontato"
        
        var objReturn: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:parametros,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? NSDictionary)!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? NSDictionary)!
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

    func alterar(parametros: [String:Any], completionHandler: ((NSDictionary) -> ())?) {
        
        let urlString = "http://sekron.azurewebsites.net/api/contato/alterarcontato"
        
        var objReturn: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:parametros,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? NSDictionary)!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? NSDictionary)!
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
    
    func deletar(codContato: Int, completionHandler: ((NSDictionary) -> ())?) {
        
        let urlString = "http://sekron.azurewebsites.net/api/contato/deletarContato?id=\(codContato)"
        
        var objReturn: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 200:
                    let result = response.result.value
                    objReturn = (result as? NSDictionary)!
                    print(objReturn as Any)
                    
                default:
                    
                    if let result = response.result.value {
                        objReturn = (result as? NSDictionary)!
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
