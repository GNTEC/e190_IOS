//
//  TokenViewController.swift
//  e190
//
//  Created by Marcelo Pavani on 20/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class TokenViewController: UIViewController {
    
    
    @IBOutlet weak var textToken: UITextField!
    
    var indicator:ProgressIndicator?
    var emailUsuario: String = ""
    let alerta = Alert();
    let api  = ApiToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")

        // função que esconde o teclado
        self.hideKeyboardWhenTappedAround()
    }

    
    @IBAction func finalizar(_ sender: Any) {
    
        //VERICAR SE O TOKEN FOI DIGITADO
        if self.textToken.text == ""{
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem:"Favor Digite o Token !"), animated: true, completion: nil)
            return
        }
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        //CHAMA A API DE VALIDAÇÃO DE TOKEN
        if let codLogin = UserDefaults.standard.object(forKey:"codLogin") as? Int {
            
            if let codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as? Int {
                
                let parametros = [
                    "codLogin": codLogin,
                    "codUsuario": codUsuario,
                    "token": self.textToken.text!
                ] as [String : Any]
                
                api.ativarUsuario(parametros: parametros, completionHandler: { (retorno) in

                    if retorno["Message"] as? String == "Token inválido"
                    {
                        print(retorno)
                        self.present(self.alerta.alertaSimples(titulo: "Alerta", mensagem: (retorno["Message"] as? String)!), animated: true, completion: nil)
                    }
                    else
                    {
                        self.indicator?.stop()
                        
                        let alertController = UIAlertController(title: "Informação", message: retorno["Message"] as? String, preferredStyle: .alert)

                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (ok) in
                            
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as UIViewController
                            self.present(vc, animated: true, completion: nil)
                        })
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func reenviarToken(_ sender: Any) {
    
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        if let codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as? Int {
    
            api.reenviarToken(codLogin: codUsuario, completionHandler: { (retorno) in
                
                if retorno["Message"] as? String == "Token inválido"
                {
                    
                    self.indicator?.stop()
                    print(retorno)
                    self.present(self.alerta.alertaSimples(titulo: "Alerta", mensagem: (retorno["Message"] as? String)!), animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func ligarEmergencia(_ sender: Any) {
        
//        let number = URL(string: "tel prompt://987818660")
//            
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(number, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(number)
//            }
//        }
    }
    
    @IBAction func voltar(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
