//
//  EsqueciASenhaViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 29/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class EsqueciASenhaViewController: UIViewController {
    
    var strMsgRet: String = ""
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

        if strMsgRet == EsqueciASenha().SolicitaSenhaNova(email: txtEmail.text!) {
        
            print(strMsgRet)
            
        }
        else
        {
        
            // create the alert
            let alert = UIAlertController(title: "Erro", message: strMsgRet, preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        
        }
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
