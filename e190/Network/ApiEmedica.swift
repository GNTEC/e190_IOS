//
//  ApiEmedica.swift
//  e190
//
//  Created by Ivan on 19/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ApiEmedica{
    
    func AdicionarEmedica(emedica: NSDictionary, completionHeadler:@escaping (_ result: NSDictionary) -> Void){
        
        let urlString = "http://sekron.azurewebsites.net/api/emedica/adicionaremedica"
        var objEmedica: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters: (emedica as! [String: AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON{
            
            response in
            
            if let status = response.response?.statusCode{
                
                switch(status){
                
                case 200:
                    
                    let Result = response.result.value
                    objEmedica = (Result as? NSDictionary)!
                    print(objEmedica)
                    break
                    
                default:
                    
                    if let result = response.value{
                        print(result)
                    }
                }
                
                DispatchQueue.main.async {
                    completionHeadler(objEmedica)
                }
            }
        }
    }
    
    func AtualizarEmedica(emedica: NSDictionary, completionHeadler:@escaping (_ result: NSDictionary) -> Void){
        
        let urlString = "http://sekron.azurewebsites.net/api/emedica/atualizaremedica"
        var objEmedica: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:(emedica as! [String: AnyObject]), encoding: JSONEncoding.default, headers: nil).responseJSON{
            
            response in
            
            if let status = response.response?.statusCode{
                
                
                switch(status){
                case 200:
                    
                    let Result = response.value
                    objEmedica = (Result as? NSDictionary)!
                    print(objEmedica)
                    break
                    
                default:
                    
                    if let result = response.result.value{
                        print(result)
                    }
                    break
                    
                }
                
                DispatchQueue.main.async {
                    completionHeadler(objEmedica)
                }
            }
        }
    }
    
    //    func ativarUsuario(parametros: [String:Any], completionHandler: ((NSDictionary) -> ())?)
    func BuscarEmedica(codUsuario: Int, completionHandler: ((NSDictionary) -> ())?){
        
        //@POST("api/emedica/verificarcadastroemedica")
        //Call<tb_emedica> VerificarCadastroEmedica(@Query("codUsuario") long codUsuario);
        
        let urlString = "http://sekron.azurewebsites.net/api/emedica/verificarcadastroemedica?codUsuario=\(codUsuario)"
        var objEmedica: NSDictionary = [:]
        
        Alamofire.request(urlString, method: .post, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseJSON{
            
            response in
            
            if let status = response.response?.statusCode{
                
                switch(status){
                case 200:
                    
                    let Result = response.value
                    objEmedica = (Result as? NSDictionary)!
                    print(objEmedica)
                    break
                    
                default:
                    
                    if let result = response.result.value{
                        print(result)
                    }
                    break
                    
                }
                DispatchQueue.main.async(execute: {
                    completionHandler?(objEmedica)
                })
            }
        }
    }
}
