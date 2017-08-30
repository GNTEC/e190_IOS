//
//  Usuario.swift
//  e190
//
//  Created by User on 18/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import Foundation
import UIKit

class NovoUsuario {
    
    
    // DADOS DO USUARIO
    var codUsuario: Int? // 0
    var codLogin: Int? // 0
    var nome: String?
    var dataNascimento: String?
    var cpf: String?
    var rg: String?
    var celular: String?
    var telefone: String?
    var sexo: String?
    var cep: String?
    var rua: String?
    var complemento: String?
    var numero: String?
    var cidade: String?
    var estado: String?
    var ativo : Bool // false
    var voluntario: String?
    var dataCadastro: String?
    var pago: Bool?  // true
    var fotoPerfil: String?
    var uidFirebase: String? // false
    var notificacaoAmarela: Bool?
    var notificacaoLaranja: Bool?
    var notificacaoVermelha:  Bool?
    var enderecoCasa: String?
    var enderecoTrabalho: String?
    
    //DADOS DO CARRO
    var carroMarca: String?
    var carroModelo: String?
    var carroPlaca: String?
    var carroFoto: String?
    var carroCor: String?
    var cepCasa: String?
    var cepTrabalho: String?
    
    init(codUsuario:Int, codLogin:Int, nome:String, dataNascimento: String, cpf:String, rg:String, celular:String, telefone:String, sexo:String, cep:String, rua:String, complemento:String, numero:String, cidade:String, estado:String, ativo:Bool, voluntario:String, dataCadastro:String, pago:Bool, fotoPerfil:String,  uidFirebase:String, notificacaoAmarela:Bool,notificacaoLaranja:Bool, notificacaoVermelha:Bool, enderecoCasa:String, enderecoTrabalho:String, carroMarca:String, carroModelo:String, carroPlaca:String, carroFoto:String, carroCor:String, cepCasa:String, cepTrabalho:String) {
        
        self.codUsuario = codUsuario
        self.codLogin = codLogin
        self.nome = nome
        self.dataNascimento = dataNascimento
        self.cpf = cpf
        self.rg = rg
        self.celular = celular
        self.telefone = telefone
        self.sexo = sexo
        self.cep = cep
        self.rua = rua
        self.complemento = complemento
        self.numero = numero
        self.cidade = cidade
        self.estado = estado
        self.ativo = ativo
        self.voluntario = voluntario
        self.dataCadastro = dataCadastro
        self.pago = pago
        self.fotoPerfil = fotoPerfil
        self.uidFirebase = uidFirebase
        self.notificacaoAmarela = notificacaoAmarela
        self.notificacaoLaranja = notificacaoLaranja
        self.notificacaoVermelha = notificacaoVermelha
        self.enderecoCasa = enderecoCasa
        self.enderecoTrabalho = enderecoTrabalho
        self.carroMarca = carroMarca
        self.carroModelo = carroModelo
        self.carroPlaca = carroPlaca
        self.carroFoto = carroFoto
        self.carroCor = carroCor
        self.cepCasa = cepCasa
        self.cepTrabalho = cepTrabalho
    }
    
    init(json: NSDictionary) {
        
        self.codUsuario = json[NovoUsuario.keys.codUsuario] as? Int
        self.codLogin = json[NovoUsuario.keys.codLogin] as? Int
        self.nome = json[NovoUsuario.keys.nome] as? String
        self.dataNascimento = json[NovoUsuario.keys.dataNascimento] as? String
        self.cpf = json[NovoUsuario.keys.cpf] as? String
        self.rg = json[NovoUsuario.keys.rg] as? String
        self.celular = json[NovoUsuario.keys.celular] as? String
        self.telefone = json[NovoUsuario.keys.telefone] as? String
        self.sexo = json[NovoUsuario.keys.sexo] as? String
        self.cep = json[NovoUsuario.keys.cep] as? String
        self.rua = json[NovoUsuario.keys.rua] as? String
        self.complemento = json[NovoUsuario.keys.complemento] as? String
        self.numero = json[NovoUsuario.keys.numero] as? String
        self.cidade = json[NovoUsuario.keys.cidade] as? String
        self.estado = json[NovoUsuario.keys.estado] as? String
        self.ativo = json[NovoUsuario.keys.ativo] as! Bool
        self.voluntario = json[NovoUsuario.keys.voluntario] as? String
        self.dataCadastro = json[NovoUsuario.keys.dataCadastro] as? String
        self.pago = json[NovoUsuario.keys.pago] as? Bool
        self.fotoPerfil = json[NovoUsuario.keys.fotoPerfil] as? String
        self.uidFirebase = json[NovoUsuario.keys.uidFirebase] as? String
        self.notificacaoAmarela = json[NovoUsuario.keys.notificacaoAmarela] as? Bool
        self.notificacaoLaranja = json[NovoUsuario.keys.notificacaoLaranja] as? Bool
        self.notificacaoVermelha = json[NovoUsuario.keys.notificacaoVermelha] as? Bool
        self.enderecoCasa = json[NovoUsuario.keys.enderecoCasa] as? String
        self.enderecoTrabalho = json[NovoUsuario.keys.enderecoTrabalho] as? String
        self.carroMarca = json[NovoUsuario.keys.carroMarca] as? String
        self.carroModelo = json[NovoUsuario.keys.carroModelo] as? String
        self.carroPlaca = json[NovoUsuario.keys.carroPlaca] as? String
        self.carroFoto = json[NovoUsuario.keys.carroFoto] as? String
        self.carroCor = json[NovoUsuario.keys.carroCor] as? String
        self.cepCasa = json[NovoUsuario.keys.cepCasa] as? String
        self.cepTrabalho = json[NovoUsuario.keys.cepTrabalho] as? String
    }
}

extension NovoUsuario {
    
    struct keys {
        
        static let codUsuario = "codUsuario"
        static let codLogin = "codLogin"
        static let nome = "nome"
        static let dataNascimento = "dataNascimento"
        static let cpf = "cpf"
        static let rg = "rg"
        static let celular = "celular"
        static let telefone = "telefone"
        static let sexo = "sexo"
        static let cep = "cep"
        static let rua = "rua"
        static let complemento = "complemento"
        static let numero = "numero"
        static let cidade = "cidade"
        static let estado = "estado"
        static let ativo = "ativo"
        static let voluntario = "voluntario"
        static let dataCadastro = "dataCadastro"
        static let pago = "pago"
        static let fotoPerfil = "fotoPerfil"
        static let uidFirebase = "uidFirebase"
        static let notificacaoAmarela = "notificacaoAmarela"
        static let notificacaoLaranja = "notificacaoLaranja"
        static let notificacaoVermelha = "notificacaoVermelha"
        static let enderecoCasa = "enderecoCasa"
        static let enderecoTrabalho = "enderecoTrabalho"
        static let carroMarca = "carroMarca"
        static let carroModelo = "carroModelo"
        static let carroPlaca = "carroPlaca"
        static let carroFoto = "carroFoto"
        static let carroCor = "carroCor"
        static let cepCasa = "cepCasa"
        static let cepTrabalho = "cepTrabalho"
    }
    
    func toJSON() -> NSDictionary
    {
        var codUsuario: Int {
            return self.codUsuario ?? 0
        }
        
        var codLogin: Int {
            return self.codLogin ?? 0
        }
        
        var nome: String {
            return self.nome ?? ""
        }
        
        var dataNascimento: String {
            return self.dataNascimento ?? ""
        }
        
        var cpf: String {
            return self.cpf ?? ""
        }
        
        var rg: String {
            return self.rg ?? ""
        }
        
        var celular: String {
            return self.celular ?? ""
        }
        
        var telefone: String {
            return self.telefone ?? ""
        }
        
        var sexo: String {
            return self.sexo ?? ""
        }
        
        var cep: String {
            return self.cep ?? ""
        }
        
        var rua: String {
            return self.rua ?? ""
        }
        
        var complemento: String {
            return self.complemento ?? ""
        }
        
        var numero: String {
            return self.numero ?? ""
        }
        
        var cidade: String {
            return self.cidade ?? ""
        }
        
        var estado: String {
            return self.estado ?? ""
        }
        
        var ativo: Bool {
            return self.ativo
        }
        
        var voluntario: String {
            return self.voluntario ?? ""
        }
        
        var dataCadastro: String {
            return self.dataCadastro ?? ""
        }
        
        var pago: Bool {
            return self.pago!
        }
        
        var fotoPerfil: String {
            return self.fotoPerfil ?? ""
        }
        
        var uidFirebase: String {
            return self.uidFirebase ?? ""
        }
        
        var notificacaoAmarela: Bool {
            return self.notificacaoAmarela!
        }
        
        var notificacaoLaranja: Bool {
            return self.notificacaoLaranja!
        }
        
        var notificacaoVermelha: Bool {
            return self.notificacaoVermelha!
        }
        
        var enderecoCasa: String {
            return self.enderecoCasa ?? ""
        }
        
        var enderecoTrabalho: String {
            return self.enderecoTrabalho ?? ""
        }
        
        var carroMarca: String {
            return self.carroMarca ?? ""
        }
        
        var carroModelo: String {
            return self.carroModelo ?? ""
        }
        
        var carroPlaca: String {
            return self.carroPlaca ?? ""
        }
        
        var carroFoto: String {
            return self.carroFoto ?? ""
        }
        
        var carroCor: String {
            return self.carroCor ?? ""
        }
        
        var cepCasa: String {
            return self.cepCasa ?? ""
        }
        
        var cepTrabalho: String {
            return self.cepTrabalho ?? ""
        }
        
        let json: NSDictionary = [
            keys.codUsuario: codUsuario,
            keys.codLogin: codLogin,
            keys.nome: nome,
            keys.dataNascimento : dataNascimento,
            keys.cpf:cpf,
            keys.rg : rg,
            keys.celular: celular,
            keys.telefone: telefone,
            keys.sexo: sexo,
            keys.cep: cep,
            keys.rua: rua,
            keys.complemento: complemento,
            keys.numero: numero,
            keys.cidade: cidade,
            keys.estado: estado,
            keys.ativo: ativo,
            keys.voluntario : voluntario,
            keys.dataCadastro: dataCadastro,
            keys.pago: pago,
            keys.fotoPerfil: fotoPerfil,
            keys.uidFirebase: uidFirebase,
            keys.notificacaoAmarela: notificacaoAmarela,
            keys.notificacaoLaranja: notificacaoLaranja,
            keys.notificacaoVermelha: notificacaoVermelha,
            keys.enderecoCasa: enderecoCasa,
            keys.enderecoTrabalho: enderecoTrabalho,
            keys.carroMarca:carroMarca,
            keys.carroModelo:carroModelo,
            keys.carroPlaca: carroPlaca,
            keys.carroFoto:carroFoto,
            keys.carroCor: carroCor,
            keys.cepCasa: cepCasa,
            keys.cepTrabalho: cepTrabalho
        ]
        
        return json
    }
}



