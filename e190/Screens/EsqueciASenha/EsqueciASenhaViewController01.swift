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
        
        //CHAMA A API PARA CADASTRAR NOVA SENHA
        let api = EsqueciASenha()
        api.RedefinirSenha(email: self.email, senhaProvisoria: self.txtSenhaProvisoria.text!, senhaNova: self.txtSenhaNova.text!) { _ in
            
            // create the alert
            let alert = UIAlertController(title: "Informação", message: "Senha Alterada com Sucesso !", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "segueRedefinirSenhaLogin", sender: nil)
        }
    }
    
    @IBAction func btnFechar(_ sender: Any) {
    
        self.txtSenhaNova.text = ""
        self.txtSenhaProvisoria.text = ""
        self.txtConfirmarSenha.text = ""
        
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
