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
    func salvar(codUsuario:Int, cepCasa:String, enderecoCasa: String, cepTrabalho:String,enderecoTrabalho:String,  completionHandler: ((NSDictionary) -> ())?) {
        
//        @POST("api/usuario/SalvarConfiguracoes")
//        Call<String> SalvarConfiguracoes(@Query("codUsuario") long codUsuario,
//        @Query("cepCasa") String cepCasa,
//        @Query("enderecoCasa") String enderecoCasa,
//        @Query("cepTrabalho") String cepTrabalho,
//        @Query("enderecoTrabalho") String enderecoTrabalho);
    
//        let urlString = "http://sekron.azurewebsites.net/api/usuario/SalvarConfiguracoes?codUsuario=\(codUsuario)&cepCasa=\'" + cepCasa + "'" + "&enderecoCasa=\'" + enderecoCasa + "'" + "&cepTrabalho=\'" + cepTrabalho + "'" + "&enderecoTrabalho=\'" + enderecoTrabalho + "'"
        
        //let myString = "I love \"unnecessary\" quotation marks"
        //let myText = "\""
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/SalvarConfiguracoes?codUsuario=\(codUsuario)&cepCasa=\(cepCasa)&enderecoCasa=\(enderecoCasa)&cepTrabalho=\(cepTrabalho)&enderecoTrabalho=\(enderecoTrabalho)"
        
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
