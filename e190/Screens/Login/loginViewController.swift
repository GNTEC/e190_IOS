//
//  loginViewController.swift
//  e190
//
//  Created by User on 12/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var swLembraLogin: UILabel!
    
    
    var indicator:ProgressIndicator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            "serialChip": "89551018439007564806"
        ]

        /*
        let parametros = [
            
            "email":"teste@teste.com",
            "senha":"1234",
            "serialChip":"89551020407005425391"
        ]
        */
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        let urlString = "http://sekron.azurewebsites.net/api/login/logar"
        
        Alamofire.request(urlString, method: .post, parameters: parametros,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainController") as UIViewController
                self.present(vc, animated: true, completion: nil)
                
                self.indicator!.stop()
                break
            case .failure(let error):
                
                print(error)
                self.indicator!.stop()
                
                // create the alert
                let alert = UIAlertController(title: "Erro", message: "Login ou Senha Inválidos", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func btnEsqueciSenha(_ sender: Any) {
        
        
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
