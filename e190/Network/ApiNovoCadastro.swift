//
//  ApiNovoCadastro.swift
//  e190
//
//  Created by Marcelo Pavani on 21/06/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiNovoCadastro {
    
    //https://viacep.com.br/ws/09531000/json/
    var objEndereco: NSDictionary = [:]
    
    func buscaEnderecoPorCep (cep: String, completionHandler:@escaping (NSDictionary)-> Void)
    {
        let urlapi = "https://viacep.com.br/ws/"
        let url = urlapi + cep + "/json/"
    
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    self.objEndereco = [:]
                default:
                    
                    let Result = response.result.value
                    self.objEndereco = (Result as? NSDictionary)!
                    
                    if let msgErro = self.objEndereco.object(forKey: "erro"){
                        
                        self.objEndereco = [:]
                    }
                        
                    break
                }
            }
            DispatchQueue.main.async(execute: {
                completionHandler(self.objEndereco)
            })
        }
    }
    
    func inclui(usuario: Array<Any>, compeletionHandler:@escaping (Bool)-> Void) {
        
        let urlString = "http://sekron.azurewebsites.net/api/usuario/novousuario"
        
        
//        @POST("api/usuario/novousuario")
//        Call<tb_usuario> NovoUsuario(@Body tb_usuario usuario);
        
    }
    
    
}
