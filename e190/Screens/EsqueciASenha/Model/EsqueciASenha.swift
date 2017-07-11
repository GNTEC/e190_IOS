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
    
    func SolicitaSenhaNova (email: String, completionHandler:@escaping (_ result:Int) ->Void){

        let urlString = "http://sekron.azurewebsites.net/api/redefinirsenha/redefinirSenha?email=" + email
        
        var ret: Int = 0
        
        Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    //ret = "Erro no envio da senha"
                    ret = 1
                
                default:
                    //ret = "Senha provisória enviada por email"
                    ret = 0
                }
                DispatchQueue.main.async(execute: { 
                    completionHandler(ret)
                })
                
            }
        }

    }
    
    func RedefinirSenha (email: String, senhaProvisoria: String, senhaNova: String, completionHandler:@escaping (_ result:Int) ->Void) {
        
        
        let urlString = "http://sekron.azurewebsites.net/api/redefinirsenha/atualizaSenha?email=" + email + "&senhaProvisoria=" + senhaProvisoria + "&senhaNova=" + senhaNova
        
        var ret: Int = 0
        
//        POST: http://www.mysite.com/api/create?param1=value&param2=value
//        HTTP Body: { foo : [ bar, foo], bar: foo}
        
        //    @POST("api/redefinirsenha/atualizaSenha")
        //    Call<String> AtualizaSenha(@Query("email") String email,
        //    @Query("senhaProvisoria") String senhaProvisoria,
        //    @Query("senhaNova") String senhaNova);
        
        Alamofire.request(urlString, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    ret = 1
                    
                default:
                    ret = 0
                }
                DispatchQueue.main.async(execute: {
                    completionHandler(ret)
                })
            }
        }
    }
    
}
