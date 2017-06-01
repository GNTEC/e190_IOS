//
//  EsqueciASenhaViewController01.swift
//  e190
//
//  Created by Marcelo Pavani on 29/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class EsqueciASenhaViewController01: UIViewController {

    
    @IBOutlet weak var txtSenhaProvisoria: UITextField!
    @IBOutlet weak var txtSenhaNova: UITextField!
    @IBOutlet weak var txtConfirmarSenha: UITextField!
    var email: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func btnEnviar(_ sender: Any){
        
        // VEIRICA SE OS CAMPOS OBRIGATÓRIOS FORAM PREENCHIDOS
        if txtSenhaProvisoria.text == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Favor Preencher a Senha Provisória", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if txtSenhaNova.text == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Favor Preencher a Nova Senha", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }

        if txtConfirmarSenha.text == "" {
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Favor Confirmar a Senha", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        
        }
        
        if EsqueciASenha().RedefinirSenha(email: email, senhaProvisoria: txtSenhaProvisoria.text!, senhaNova: txtSenhaNova.text!) == 0 {
            
            //self.performSegue(withIdentifier: "segueRedefinirSenha", sender: nil)
            
            let vc = LoginViewController()
            self.present(vc, animated: true, completion: nil)
            
        }
        else
        {
            
            // create the alert
            let alert = UIAlertController(title: "Erro", message: "Erro no Envio de Email", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
            
        }
        
    }
    
    @IBAction func btnFechar(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
