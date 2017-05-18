//
//  Usuario.swift
//  e190
//
//  Created by User on 18/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import ObjectMapper

class Usuario : Mappable {
    
    var id: Int
    var id_usuario: Int
    var id_franquia: Int
    var cep: String?
    var logradouro: String?
    var numero: String?
    var complemento: String?
    var bairro: String?
    var cidade: String?
    var uf: String?
    var tipo: Int
    var atualizacao: String?
    
    
    required init?(map: Map) {
        id = 0
        id_franquia = 0
        id_usuario = 0
        tipo = 0
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        id_usuario   <- map["id_usuario"]
        id_franquia   <- map["id_franquia"]
        cep   <- map["cep"]
        logradouro   <- map["logradouro"]
        numero   <- map["numero"]
        complemento   <- map["complement"]
        bairro   <- map["bairro"]
        cidade   <- map["cidade"]
        uf   <- map["uf"]
        tipo   <- map["tipo"]
        atualizacao   <- map["atualizacao"]
    }
}
