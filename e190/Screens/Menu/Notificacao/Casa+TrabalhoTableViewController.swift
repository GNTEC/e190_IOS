//
//  Casa+TrabalhoTableViewController.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 04/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import SwiftMaskText

class Casa_TrabalhoTableViewController: UITableViewController {

    @IBOutlet weak var text_cep_casa: SwiftMaskField!
    @IBOutlet weak var text_end_casa: UILabel!
    @IBOutlet weak var text_cep_trabalho: SwiftMaskField!
    @IBOutlet weak var text_endereco_trabalho: UILabel!
    
    var indicator:ProgressIndicator?
    var atualizarDados: Bool = false
    var codUsuario: Int = 0
    var objUsuario : [String:Any] = [:]
    let alerta = Alert();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.buscarEndereco()
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        let api = ApiCasa_Trabalho()
        let removeMascara = CustomTextField()
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        if (validaCampos())
        {
            if ((UserDefaults.standard.object(forKey:"codUsuario") as? Int) != nil)
            {
                let codUsuario = UserDefaults.standard.object(forKey:"codUsuario") as? Int
                let cepCasaSemMascara = removeMascara.removeMascara(text: self.text_cep_casa, mascara: "NNNNN-NNN")
                let cepTrabalhoSemMascara = removeMascara.removeMascara(text: self.text_cep_trabalho, mascara: "NNNNN-NNN")
                
                api.salvar(codUsuario: codUsuario!, cepCasa: cepCasaSemMascara, enderecoCasa: text_end_casa.text!, cepTrabalho: cepTrabalhoSemMascara, enderecoTrabalho: self.text_endereco_trabalho.text!, completionHandler: { (retorno) in
                    
                    let alertController = UIAlertController(title: "Informação", message: "Dados Incluídos com Sucesso !", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                        //self.dismiss(animated: true, completion: nil)
                        self.indicator!.stop()
                        self.buscarEndereco()
                    })
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                })
            }
            else
            {
                self.indicator!.stop()
            }
        }
    }
    
    @IBAction func buscarEnderecoCasa(_ sender: Any) {
        
        let api = ApiNovoCadastro()
        let removeMascara = CustomTextField()
        
        if self.text_cep_casa.text != ""{
            
            self.view.addSubview(indicator!)
            self.indicator!.start()
            
            // remove mascara
            let cepSemMascara = removeMascara.removeMascara(text: self.text_cep_casa, mascara: "NNNNN-NNN")
        
            api.buscaEnderecoPorCep(cep: cepSemMascara, completionHandler: { (retorno) in
            
                self.text_cep_casa.text = retorno["cep"] as? String
                
                let logradouro = retorno["logradouro"] as! String
                let bairro = retorno["bairro"] as! String
                let localidade = retorno["localidade"] as! String
                let uf = retorno["uf"] as! String
                
                self.text_end_casa.text = "\(logradouro) \(bairro) \(localidade) \(uf)"
                
                self.indicator!.stop()
                
            })
        }
        else
        {
            self.indicator!.stop()
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Digitar o CEP do Trabalho !"), animated: true, completion: nil)
        }
    }
    
    @IBAction func buscarEnderecoTrabalho(_ sender: Any) {
        
        let api = ApiNovoCadastro()
        let removeMascara = CustomTextField()
        
        if self.text_cep_trabalho.text != ""{
            
            self.view.addSubview(indicator!)
            self.indicator!.start()
         
            // remove mascara
            let cepSemMascara = removeMascara.removeMascara(text: self.text_cep_trabalho, mascara: "NNNNN-NNN")
            
            api.buscaEnderecoPorCep(cep: cepSemMascara, completionHandler: { (retorno) in
              
                self.text_cep_trabalho.text = retorno["cep"] as? String

                let logradouro = retorno["logradouro"] as! String
                let bairro = retorno["bairro"] as! String
                let localidade = retorno["localidade"] as! String
                let uf = retorno["uf"] as! String
                
                self.text_endereco_trabalho.text = "\(logradouro) \(bairro) \(localidade) \(uf)"
                
                self.indicator!.stop()
                
            })
        }
        else
        {
            self.indicator!.stop()
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Digitar o CEP do Trabalho !"), animated: true, completion: nil)
        }
    }
    
    
    func buscarEndereco()
    {
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        if UserDefaults.standard.value(forKey: "dict") != nil
        {
            objUsuario = UserDefaults.standard.value(forKey: "dict") as! [String : Any]
            
            //VERIFICA SE EXISTE ENDEREÇO TRABALHO E CASA
            if let enderecoCasa = objUsuario["enderecoCasa"]{
                
                self.text_end_casa.text = enderecoCasa as? String
                self.atualizarDados = true
            }
        
            if let enderecoTrabalho = objUsuario["enderecoTrabalho"]{
            
                self.text_endereco_trabalho.text = enderecoTrabalho as? String
                self.atualizarDados = true
            }
        }
    }
    
    
    func validaCampos()-> Bool
    {
        
        if self.text_cep_casa.text == ""{
         
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Digitar o CEP do Trabalho !"), animated: true, completion: nil)
            
            return false
        }
            
        if self.text_cep_trabalho.text == ""{
            
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem: "Favor Digitar o CEP do Trabalho !"), animated: true, completion: nil)
            
            return false
        }
        
        
        return true
    
    }
    
    @IBAction func voltar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
