//
//  loginViewController.swift
//  e190
//
//  Created by User on 12/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu

class LoginViewController: UIViewController {
        
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var swLembraLogin: UISwitch!

    var indicator:ProgressIndicator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.object(forKey: "email") != nil) {
        
            txtEmail.text = UserDefaults.standard.object(forKey:"email") as? String
            txtSenha.text = UserDefaults.standard.object(forKey: "senha") as? String
        }
    
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnlogon(_ sender: Any) {
        
        // VEIRICA SE OS CAMPOS OBRIGATÓRIOS FORAM PREENCHIDOS
        if txtEmail.text == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Favor Preencher o Email", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
    
        if txtSenha.text == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Favor Preencher o Email", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        let parametros = [

            "email": self.txtEmail.text!,
            "senha": self.txtSenha.text!,
            "serialChip":"1"
        ]
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        let api  = ApiLogin()
        
        api.login(usuario: parametros) { (retorno) in
            
            let alerta = Alert();
            
            if self.swLembraLogin.isOn == true {
                
                UserDefaults.standard.setValue(self.txtEmail.text, forKey: "email")
                UserDefaults.standard.setValue(self.txtSenha.text, forKey: "senha")
            }
            else {
                
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "senha")
            }
            
            if retorno.count == 1 {
            
                if let messeErro = retorno["Message"]{
                    
                    if messeErro as! String  == "Usuario inativo" {
                        
                        self.indicator!.stop()
                        
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "TokenViewController") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                    else
                    {
                        self.present(alerta.alertaSimples(titulo: "Alerta", mensagem:messeErro  as! String), animated: true, completion: nil)
                        self.indicator!.stop()
                        return
                    }
                }
            }
            else if retorno.count > 2
            {
                //GRAVA VARIAVEIS DE AMBIENTE
                UserDefaults.standard.setValue(retorno["codLogin"], forKey: "codLogin")
                UserDefaults.standard.setValue(retorno["codUsuario"], forKey: "codUsuario")
                UserDefaults.standard.setValue(retorno["nome"], forKey: "nome")
                UserDefaults.standard.set(true, forKey: "logado")
                
                // SALVA OS DADOS DO USAURIO COMPARTILHADO
                let objUsuario = NovoUsuario(json: retorno).toJSON()
                UserDefaults.standard.set(objUsuario, forKey: "dict")
                
                self.indicator!.stop()
                self.performSegue(withIdentifier: "segueLogin", sender: nil)
            }
        }
    }
    
    @IBAction func btnEsqueciSenha(_ sender: Any)
    {

        
    }
    
    @IBAction func btnNovaConta(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
