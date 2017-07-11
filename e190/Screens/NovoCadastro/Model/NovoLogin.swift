//
//  Login.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 04/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class NovoLogin
{
    //        this.codLogin = codLogin;        this.email = email;        this.senha = senha;        this.token = token;        this.serialChip = telefone;
    //
    var codLogin: Int? // 0
    var email: String? // 0
    var senha: String?
    var token: String?
    var serialChip: String?
    
    
    init(codLogin: Int, email: String, senha: String, token: String, serialChip: String) {
        
        self.codLogin = codLogin
        self.email = email
        self.senha = senha
        self.token = token
        self.serialChip = serialChip

    }
    
    init(json: NSDictionary) {
        
        self.codLogin = json[NovoLogin.keys.codLogin] as? Int
        self.email = json[NovoLogin.keys.email] as? String
        self.senha = json[NovoLogin.keys.senha] as? String
        self.token = json[NovoLogin.keys.token] as? String
        self.serialChip = json[NovoLogin.keys.serialChip] as? String
    }
}
extension NovoLogin {
    
    struct keys {
        static let codLogin = "codLogin"
        static let email = "email"
        static let senha = "senha"
        static let token = "token"
        static let serialChip = "serialChip"
    }
    
    func toJSON() -> NSDictionary
    {
        var codLogin: Int {
            return self.codLogin ?? 0
        }
        
        var email: String {
            return self.email ?? ""
        }
        
        var senha: String {
            return self.senha ?? ""
        }
        
        var token: String {
            return self.token ?? ""
        }
        
        var serialChip: String {
            return self.serialChip ?? ""
        }
        
        
        let json: NSDictionary = [
            keys.codLogin: codLogin,
            keys.email: email,
            keys.senha: senha,
            keys.token: token,
            keys.serialChip: serialChip
        ]
        
        return json
        
    }
}
