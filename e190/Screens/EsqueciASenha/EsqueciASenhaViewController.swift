//
//  EsqueciASenhaViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 29/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class EsqueciASenhaViewController: UIViewController {
    
    var apiSenha: EsqueciASenha?
    
    @IBOutlet weak var txtEmail: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func btnFechar(_ sender: Any) {
        
        self.txtEmail.text = ""
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnEnviar(_ sender: Any) {
        
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
        
        //CHAMA A API PARA ENVIO DE EMAIL
        
        let api = EsqueciASenha()
        
        api.SolicitaSenhaNova(email: self.txtEmail.text!) {_ in 
            
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Senha Enviada com Sucesso !", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "segueRedefinirSenha", sender: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueRedefinirSenha" {
            
            let vc = segue.destination as! EsqueciASenhaViewController01
            vc.email = self.txtEmail.text!
        }
    }
}
