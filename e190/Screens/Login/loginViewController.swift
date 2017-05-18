//
//  loginViewController.swift
//  e190
//
//  Created by User on 12/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import Alamofire
import NMPopUpViewSwift

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var swLembraLogin: UISwitch!
    
    var popViewController : PopUpViewControllerSwift!


    var indicator:ProgressIndicator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.value(forKey: "email") != nil) {
        
            txtEmail.text = UserDefaults.standard.value(forKey: "email") as? String
            txtSenha.text = UserDefaults.standard.value(forKey: "senha") as? String
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
            "serialChip": "89551018439007564806"
        //let x = UIDevice.current.identifierForVendor!.uuidString
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
            
            if let status = response.response?.statusCode {
                
                switch(status){
                case 400:
                    if let result = response.result.value {
                    
                        
                        let msgRet = result as? NSDictionary
                        let strMessegeRet = msgRet?["Message"] as! String
                        
                        self.indicator!.stop()
                        
                        // create the alert
                        let alert = UIAlertController(title: "Erro", message: strMessegeRet, preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)

                    }
                    
                default:

                    let Result = response.result.value
                    let objUser = Result as? NSDictionary
                    print(objUser)
                    
                    self.indicator!.stop()
                    
                    if self.swLembraLogin.isOn == true {
                        
                        UserDefaults.standard.setValue(self.txtEmail.text, forKey: "email")
                        UserDefaults.standard.setValue(self.txtSenha.text, forKey: "senha")
                    }
                    else {
                        
                        UserDefaults.standard.setValue("", forKey: "email")
                        UserDefaults.standard.setValue("", forKey: "senha")
                    }
                    
                    self.performSegue(withIdentifier: "segueLogin", sender: nil)
                    
                    /*
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainController") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                    */
 
                    break
                    
                }
            }

        }
    }
    
    @IBAction func btnEsqueciSenha(_ sender: Any)
    {
    
        let bundle = Bundle(for: PopUpViewControllerSwift.self)
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPad", bundle: bundle)
            self.popViewController.title = "This is a popup view"
            self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
        } else
        {
            if UIScreen.main.bounds.size.width > 320 {
                if UIScreen.main.scale == 3 {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6Plus", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
                } else {
                    self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6", bundle: bundle)
                    self.popViewController.title = "This is a popup view"
                    self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
                }
            } else {
                self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: bundle)
                self.popViewController.title = "This is a popup view"
                self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
            }
        }
        
        print ("Teste")
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
