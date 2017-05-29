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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func btnEnviar(_ sender: Any){
        
        
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
