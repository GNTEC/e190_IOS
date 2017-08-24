//
//  Notificacao.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 03/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class Notificacao {

    var codUsuario: Int
    var notificacaoVermelha:Bool? // 0
    var notificacaoLaranja: Bool? // 0
    var notificacaoAmarela: Bool?
    
    init(codUsuario:Int, notificacaoVermelha:Bool, notificacaoLaranja: Bool, notificacaoAmarela: Bool) {
        
        self.codUsuario = codUsuario
        self.notificacaoVermelha = notificacaoVermelha
        self.notificacaoLaranja = notificacaoLaranja
        self.notificacaoAmarela = notificacaoAmarela
    }
    
    init(json: NSDictionary) {
        
        self.codUsuario = json[Notificacao.keys.codUsuario] as! Int
        self.notificacaoVermelha = json[Notificacao.keys.notificacaoVermelha] as? Bool
        self.notificacaoLaranja = json[Notificacao.keys.notificacaoLaranja] as? Bool
        self.notificacaoAmarela = json[Notificacao.keys.notificacaoAmarela] as? Bool
    }
}
extension Notificacao {
    
    struct keys {
        static let codUsuario = "codUsuario"
        static let notificacaoVermelha = "notificacaoVermelha"
        static let notificacaoLaranja = "notificacaoLaranja"
        static let notificacaoAmarela = "notificacaoAmarela"
    }
    
    func toJSON() -> NSDictionary
    {
        var codUsuario: Int {
            return self.codUsuario
        }
        
        var notificacaoVermelha: Bool {
            return self.notificacaoVermelha ?? false
        }
        
        var notificacaoLaranja: Bool {
            return self.notificacaoLaranja ?? false
        }
        
        var notificacaoAmarela: Bool {
            return self.notificacaoAmarela ?? false
        }
        
        
        let json: NSDictionary = [
            keys.codUsuario: codUsuario,
            keys.notificacaoVermelha: notificacaoVermelha,
            keys.notificacaoLaranja: notificacaoLaranja,
            keys.notificacaoAmarela: notificacaoAmarela
            ]
        
        return json
    }
}

