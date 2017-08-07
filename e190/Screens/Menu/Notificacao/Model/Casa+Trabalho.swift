//
//  Casa+Trabalho.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 04/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class Casa_Trabalho {
    
    //        @POST("api/usuario/SalvarConfiguracoes")
    //        Call<String> SalvarConfiguracoes(@Query("codUsuario") long codUsuario,
    //        @Query("cepCasa") String cepCasa,
    //        @Query("enderecoCasa") String enderecoCasa,
    //        @Query("cepTrabalho") String cepTrabalho,
    //        @Query("enderecoTrabalho") String enderecoTrabalho);
    
    
    var codUsuario: Int
    var cepCasa:String? // 0
    var enderecoCasa: String? // 0
    var cepTrabalho: String?
    var enderecoTrabalho: String?
    
    init(codUsuario:Int, cepCasa:String, enderecoCasa: String, cepTrabalho: String, enderecoTrabalho: String) {
        
        self.codUsuario = codUsuario
        self.cepCasa = cepCasa
        self.enderecoCasa = enderecoCasa
        self.cepTrabalho = cepTrabalho
        self.enderecoTrabalho = enderecoTrabalho
    }
    
    init(json: NSDictionary) {
        
        self.codUsuario = json[Casa_Trabalho.keys.codUsuario] as! Int
        self.cepCasa = json[Casa_Trabalho.keys.cepCasa] as? String
        self.enderecoCasa = json[Casa_Trabalho.keys.enderecoCasa] as? String
        self.cepTrabalho = json[Casa_Trabalho.keys.cepTrabalho] as? String
        self.enderecoTrabalho = json[Casa_Trabalho.keys.enderecoTrabalho] as? String
    }
}
extension Casa_Trabalho {
    
    struct keys {
        static let codUsuario = "codUsuario"
        static let cepCasa = "cepCasa"
        static let enderecoCasa = "enderecoCasa"
        static let cepTrabalho = "cepTrabalho"
        static let enderecoTrabalho = "enderecoTrabalho"
    }
    
    func toJSON() -> NSDictionary
    {
        var codUsuario: Int {
            return self.codUsuario
        }
        
        var cepCasa: String {
            return self.cepCasa ?? ""
        }
        
        var enderecoCasa: String {
            return self.enderecoCasa ?? ""
        }
        
        var cepTrabalho: String {
            return self.cepTrabalho ?? ""
        }
        
        var enderecoTrabalho: String {
            return self.enderecoTrabalho ?? ""
        }
        
        let json: NSDictionary = [
            keys.codUsuario: codUsuario,
            keys.cepCasa: cepCasa,
            keys.enderecoCasa: enderecoCasa,
            keys.cepTrabalho: cepTrabalho,
            keys.enderecoTrabalho: enderecoTrabalho
        ]
        
        return json
    }
}


