//
//  EmergenciaMedica.swift
//  e190
//
//  Created by Ivan on 19/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class EmergenciaMedica{
    
    var codUsuario : Int?
    var cartaoSus : String?
    var planoSaude : String?
    var numeroPlanoSaude : String?
    var problemaSaude : String?
    var notasMedicas : String?
    var alergiasReacoes : String?
    var medicamentos : String?
    var tipoSanguineo : String?
    var peso : String?
    var altura : String?
    
    init(codUsuario : Int, cartaoSus : String, planoSaude : String, numeroPlanoSaude : String, problemaSaude : String, notasMedicas : String, alergiasReacoes : String, medicamentos : String, tipoSanguineo : String, peso : String, altura : String ){
        
        self.codUsuario = codUsuario
        self.cartaoSus = cartaoSus
        self.planoSaude = planoSaude
        self.numeroPlanoSaude = numeroPlanoSaude
        self.problemaSaude = problemaSaude
        self.notasMedicas = notasMedicas
        self.alergiasReacoes = alergiasReacoes
        self.medicamentos = medicamentos
        self.tipoSanguineo = tipoSanguineo
        self.peso = peso
        self.altura = altura
        
    }
    
    init(json: NSDictionary){
        
        self.codUsuario = json[EmergenciaMedica.keys.codUsuario] as? Int
        self.cartaoSus = json[EmergenciaMedica.keys.cartaoSus] as? String
        self.planoSaude = json[EmergenciaMedica.keys.planoSaude] as? String
        self.numeroPlanoSaude = json[EmergenciaMedica.keys.numeroPlanoSaude] as? String
        self.problemaSaude = json[EmergenciaMedica.keys.problemaSaude] as? String
        self.notasMedicas = json[EmergenciaMedica.keys.notasMedicas] as? String
        self.alergiasReacoes = json[EmergenciaMedica.keys.alergiasReacoes] as? String
        self.medicamentos = json[EmergenciaMedica.keys.medicamentos] as? String
        self.tipoSanguineo = json[EmergenciaMedica.keys.tipoSanguineo] as? String
        self.peso = json[EmergenciaMedica.keys.peso] as? String
        self.altura = json[EmergenciaMedica.keys.altura] as? String
        
    }
}

extension EmergenciaMedica {
    
    struct keys{
        
        static let codUsuario = "codUsuario"
        static let cartaoSus = "cartaoSus"
        static let planoSaude = "planoSaude"
        static let numeroPlanoSaude = "numeroPlanoSaude"
        static let problemaSaude = "problemaSaude"
        static let notasMedicas = "notasMedicas"
        static let alergiasReacoes = "alergiasReacoes"
        static let medicamentos = "medicamentos"
        static let tipoSanguineo = "tipoSanguineo"
        static let peso = "peso"
        static let altura = "altura"
        
    }
    
    
    func toJSON() -> NSDictionary{
        
        var codUsuario: Int {
            return self.codUsuario ?? 0
        }
        
        var cartaoSus: String {
            return self.cartaoSus ?? ""
        }
        
        var planoSaude: String {
            return self.planoSaude ?? ""
        }
        
        var numeroPlanoSaude: String {
            return self.numeroPlanoSaude ?? ""
        }
        
        var problemaSaude: String {
            return self.problemaSaude ?? ""
        }
        
        var notasMedicas: String {
            return self.notasMedicas ?? ""
        }
        
        var alergiasReacoes: String {
            return self.alergiasReacoes ?? ""
        }
        
        var medicamentos: String {
            return self.medicamentos ?? ""
        }
        
        var tipoSanguineo: String {
            return self.tipoSanguineo ?? ""
        }
        
        var peso: String {
            return self.peso ?? ""
        }
        
        var altura: String {
            return self.altura ?? ""
        }
        
        let json: NSDictionary = [
            
            keys.codUsuario: codUsuario,
            keys.cartaoSus : cartaoSus,
            keys.planoSaude: planoSaude,
            keys.numeroPlanoSaude: numeroPlanoSaude,
            keys.problemaSaude: problemaSaude,
            keys.notasMedicas: notasMedicas,
            keys.alergiasReacoes: alergiasReacoes,
            keys.medicamentos: medicamentos,
            keys.tipoSanguineo: tipoSanguineo,
            keys.peso: peso,
            keys.altura: altura
            
        ]
        
        return json
    }
}
