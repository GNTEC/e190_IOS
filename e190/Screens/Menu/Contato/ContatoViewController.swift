//
//  ContatoViewController.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 01/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import SwiftMaskText

class ContatoViewController: UIViewController {

    @IBOutlet weak var text_nome: UITextField!
    @IBOutlet weak var text_telefone: SwiftMaskField!
    @IBOutlet weak var text_email: UITextField!
    
    var atualizarDados: Bool = false
    var codUsuario: Int = 0
    var codContato: Int = 0
    var indicator:ProgressIndicator?
    var contato: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        
        if contato.count > 0
        {
            carregaContato(parametro: contato)
            self.atualizarDados = true
        }
    }
    
    @IBAction func salvarContato(_ sender: Any) {
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
    
        if validarCampos() {
        
            if !atualizarDados {
                
                //salvar
                if(self.gravar()){
                
                    self.indicator!.stop()
                    
                    let alertController = UIAlertController(title: "Informação", message: "Dados Incluídos com Sucesso !", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else
                {
                    // ERRO !
                    self.indicator!.stop()
                }
            }
            //alterar
            else
            {
                if(self.atualizar()){
                    
                    self.indicator!.stop()
                    
                    let alertController = UIAlertController(title: "Informação", message: "Dados Atualizados com Sucesso !", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                
                }
                else
                {
                    // ERRO !
                    self.indicator!.stop()
                }
            }
        }
        else
        {
            // else dos campos obrigatorios
            self.indicator!.stop()
        }
    }
    
    func gravar() -> Bool
    {
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        let removeMascara = CustomTextField()
        let api  = ApiContato()
        
        //REMOVE MASCARA
        let telefoneFixoSemMascara = removeMascara.removeMascara(text: self.text_telefone, mascara: "(NN) NNNN-NNNN")
    
        // CHAMA A FUNÇÃO QUE GRAVA O LOGIN
        let model = Contato(codUsuario:codUsuario,codContato:self.codContato,  nome:self.text_nome.text! , email: text_email.text!, telefone: telefoneFixoSemMascara).toJSON()
        
        api.salvar(parametros: model as! [String : Any]) { (retorno) in
            
            let alertController = UIAlertController(title: "Informação", message: "Alteração realizada com Sucesso !", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                self.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        return true
    }
    
    func atualizar() -> Bool
    {
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
    
        let removeMascara = CustomTextField()
        let api  = ApiContato()
        
        //REMOVE MASCARA
        let telefoneFixoSemMascara = removeMascara.removeMascara(text: self.text_telefone, mascara: "(NN) NNNN-NNNN")
        
        // CHAMA A FUNÇÃO QUE GRAVA O LOGIN
        let model = Contato(codUsuario:codUsuario, codContato: self.codContato, nome:self.text_nome.text! , email: text_email.text!, telefone: telefoneFixoSemMascara).toJSON()
        
        api.alterar(parametros: model as! [String : Any]) { (retorno) in
            
            
        }
        
        return true
    }
    
    func carregaContato(parametro: NSDictionary){
    
        self.codContato = parametro["codContato"] as! Int
        self.text_nome.text = parametro["nome"] as? String
        self.text_telefone.text = parametro["telefone"] as? String
        self.text_email.text = parametro["email"] as? String
        
    }

    func validarCampos() -> Bool
    {
        let alerta = Alert();
        
        if text_nome.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Nome !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_telefone.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o Telefone !"), animated: true, completion: nil)
            
            return false
        }
        
        if text_email.text == "" {
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Preencher o EMail !"), animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
