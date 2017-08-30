//
//  SideMenuTableView.swift
//  e190
//
//  Created by User on 09/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit


class SideMenuTableView: UITableViewController {
    
    @IBOutlet weak var label_nomeUsuario: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // VERIFA O NOME DO USUARIO
        if let nomeUsuario = UserDefaults.standard.object(forKey:"nome") as? String {
            self.label_nomeUsuario.text = nomeUsuario
        }

        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //HOME
        if indexPath.row == 0 {

            let app = UIApplication.shared.delegate as? AppDelegate
            app?.start()
        }
        
        //PERFIL
        if indexPath.row == 1 {
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "NovoCadastro") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
        //CONTATOS
        if indexPath.row == 2 {
            
            let mainStoryboard = UIStoryboard(name: "Contato", bundle: nil)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navContato") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
        //NOTIFICACAO
        if indexPath.row == 3 {
            
            let mainStoryboard = UIStoryboard(name: "Notificacao", bundle: nil)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navNotificacao") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }

        //EMEDICA
        if indexPath.row == 4 {
            
            let mainStoryboard = UIStoryboard(name: "EmergenciaMedica", bundle:nil)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "EMedica") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
<<<<<<< HEAD
        //SERVICOS ADICIONAIS
        if indexPath.row == 5 {
            
            let mainStoryboard = UIStoryboard(name: "ServicosAdcionais", bundle:nil)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navServAdicionais") as UIViewController
            self.present(vc, animated: true, completion: nil)
=======
        //SAIR
        if indexPath.row == 9 {
            
            UserDefaults.standard.set(false, forKey: "logado")
            
            let app = UIApplication.shared.delegate as? AppDelegate
            app?.start()
>>>>>>> 633917810c5123989472f26290a17a06df064820
            
        }
        
        //SAIR
        if indexPath.row == 9 {
            
            UserDefaults.standard.set(false, forKey: "logado")
            
            let app = UIApplication.shared.delegate as? AppDelegate
            app?.start()
            
        }
    }
}
