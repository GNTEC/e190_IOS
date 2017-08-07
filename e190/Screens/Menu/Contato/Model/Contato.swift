//
//  Contato.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 01/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class Contato
{
    var codUsuario: Int
    var codContato: Int
    var nome:       String? // 0
    var email:      String? // 0
    var telefone:   String?
    
    init(codUsuario:Int, codContato:Int, nome: String, email: String, telefone: String) {
        
        self.codUsuario = codUsuario
        self.codContato = codContato
        self.nome = nome
        self.email = email
        self.telefone = telefone
    }
    
    init(json: NSDictionary) {
        
        self.codUsuario = json[Contato.keys.codUsuario] as! Int
        self.codContato = json[Contato.keys.codContato] as! Int
        self.nome = json[Contato.keys.nome] as? String
        self.email = json[Contato.keys.email] as? String
        self.telefone = json[Contato.keys.telefone] as? String
    }
}
extension Contato {
    
    struct keys {
        static let codUsuario = "codUsuario"
        static let codContato = "codContato"
        static let nome = "nome"
        static let email = "email"
        static let telefone = "telefone"
    }
    
    func toJSON() -> NSDictionary
    {
        var codUsuario: Int {
            return self.codUsuario 
        }

        var codContato: Int {
            return self.codContato
        }
        
        var nome: String {
            return self.nome ?? ""
        }
        
        var email: String {
            return self.email ?? ""
        }
        
        var telefone: String {
            return self.telefone ?? ""
        }
        
    
        let json: NSDictionary = [
            keys.codUsuario: codUsuario,
            keys.codContato: codContato,
            keys.nome: nome,
            keys.email: email,
            keys.telefone: telefone,
        ]
        
        return json
    }
}
