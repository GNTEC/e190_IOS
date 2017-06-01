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
        
            self.performSegue(withIdentifier: "segueRedefinirSenha", sender: self)
            
        }
        
        
//        if EsqueciASenha().SolicitaSenhaNova(email: txtEmail.text!) == 0 {
//        
//            let vc = EsqueciASenhaViewController01()
//            vc.email = txtEmail.text!
//            
//            
//            //self.present(vc, animated: true, completion: nil)
//            //self.performSegue(withIdentifier: "segueRedefinirSenha", sender: nil)
//        }
//        else
//        {
//        
//            // create the alert
//            let alert = UIAlertController(title: "Erro", message: "Erro no Envio de Email", preferredStyle: UIAlertControllerStyle.alert)
//            
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
//            
//            return
//        
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @POST("api/redefinirsenha/redefinirSenha")
//    Call<String> RedefinirSenha(@Query("email") String email);
//    
//    @POST("api/redefinirsenha/atualizaSenha")
//    Call<String> AtualizaSenha(@Query("email") String email,
//    @Query("senhaProvisoria") String senhaProvisoria,
//    @Query("senhaNova") String senhaNova);
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
