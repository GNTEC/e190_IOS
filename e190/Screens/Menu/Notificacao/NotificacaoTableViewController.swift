//
//  NotificacaoTableViewController.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 03/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class NotificacaoTableViewController: UITableViewController {

    @IBOutlet weak var sw_amarelo: UISwitch!
    @IBOutlet weak var sw_laranja: UISwitch!
    @IBOutlet weak var sw_vermelho: UISwitch!
    
    var indicator:ProgressIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.black, msg: "Aguarde....")
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.buscaConfirguracaoNotificacao()
        
    }
    
    func buscaConfirguracaoNotificacao()
    {
        let api = ApiNotificaccao()
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        //VERIFICA O CODIGO DO USUARIO
        if ((UserDefaults.standard.object(forKey:"codUsuario") as? Int) != nil)
        {
            let codUsuario = UserDefaults.standard.object(forKey:"codUsuario") as? Int
            
            api.listar(codUsuario: codUsuario!, completionHandler: { (retorno) in
            
                print(retorno)
                
                // carregar as informações dos alertas
                self.sw_amarelo.isOn = retorno["notificacaoAmarela"] as! Bool
                self.sw_laranja.isOn = retorno["notificacaoLaranja"] as! Bool
                self.sw_vermelho.isOn = retorno["notificacaoVermelha"] as! Bool
                
                self.indicator!.stop()
            })
        }
        else
        {
            self.indicator!.stop()
        }
    }

    @IBAction func salvarNotificacao(_ sender: Any) {
        
        let api = ApiNotificaccao()
        
        self.view.addSubview(indicator!)
        self.indicator!.start()
        
        if ((UserDefaults.standard.object(forKey:"codUsuario") as? Int) != nil)
        {
            let codUsuario = UserDefaults.standard.object(forKey:"codUsuario") as? Int
    
            api.atualizar(codUsuario: codUsuario!, notificacaoVermelha: self.sw_vermelho.isOn, notificacaoLaranja: self.sw_laranja.isOn, notificacaoAmarela: self.sw_amarelo.isOn, completionHandler: { (retorno) in
                
                let alertController = UIAlertController(title: "Informação", message: "Dados Incluídos com Sucesso !", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (Ok) in
                    //self.dismiss(animated: true, completion: nil)
                    self.indicator!.stop()
                    self.buscaConfirguracaoNotificacao()
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            })
        }
        else
        {
            self.indicator!.stop()
        }
    }
    
    @IBAction func casaTrabalho(_ sender: Any) {
        
    
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
    }
    
    @IBAction func voltar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
