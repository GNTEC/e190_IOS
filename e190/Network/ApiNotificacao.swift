//
//  ApiNotificacao.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 03/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//


import UIKit
import Foundation
import Alamofire

class ApiNotificaccao
{
    func atualizar(codUsuario: Int, notificacaoVermelha: Bool, notificacaoLaranja : Bool, notificacaoAmarela: Bool, completionHandler: ((NSDictionary) -> ())?) {
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/AtualizarNotificacoes?codUsuario=\(codUsuario)&notificacaoVermelha=\(notificacaoVermelha)&notificacaoLaranja=\(notificacaoLaranja)&notificacaoAmarela=\(notificacaoAmarela)"
        
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
    

    func listar(codUsuario: Int, completionHandler: (([String:Any]) -> ())?) {
        
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
                completionHandler?(objReturn)
            })
        }
    }
    
}
