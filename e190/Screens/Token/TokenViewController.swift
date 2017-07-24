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
    var emailUsuario: String = ""
    let alerta = Alert();
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func finalizar(_ sender: Any) {
        
        
        //VERICAR SE O TOKEN FOI DIGITADO
        if self.textToken.text == ""{
            self.present(alerta.alertaSimples(titulo: "Alerta", mensagem:"Favor Digite o Token !"), animated: true, completion: nil)
            return
        }
        
        
        
        
        
    }
    
    
    @IBAction func reenviarToken(_ sender: Any) {
        

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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
