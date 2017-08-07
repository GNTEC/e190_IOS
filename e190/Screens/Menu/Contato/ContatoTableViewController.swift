//
//  ContatoTableViewController.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 31/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class ContatoTableViewController: UITableViewController {

    var contatos: Array<AnyObject> = []
    var codUsuario : Int = 0
    var contatoAdcionar: Bool = false
    var contatoIndexPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.buscaContatos()
    }
    
    func buscaContatos(){
        
        let api = ApiContato()
        
        codUsuario = UserDefaults.standard.object(forKey: "codUsuario") as! Int
        
        api.listar(codUsuario: codUsuario) { (retorno) in
        
            if retorno.count > 0 {
                self.contatos = retorno
                self.tableView.reloadData()
            }
            else
            {
                self.contatos = []
            }
        }
    }

    @IBAction func voltar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let contatoSelecionado = self.contatos[indexPath.row] as! NSDictionary
        
        let cell:ContatoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "celula") as! ContatoTableViewCell

        cell.text_nome.text = contatoSelecionado["nome"] as? String
        cell.text_email.text = contatoSelecionado["email"] as? String
        cell.text_telefone.text = contatoSelecionado["telefone"] as? String

        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.contatoAdcionar = true
        performSegue(withIdentifier: "ContatoAcionar", sender: indexPath.row)
    
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            print("deletou !")
            
            self.contatoIndexPath = indexPath
            
            let contatoSelecionado = self.contatos[indexPath.row] as! NSDictionary
            confirmaDelecao(contato: contatoSelecionado)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func confirmaDelecao(contato: NSDictionary) {
        let alert = UIAlertController(title: "Contato Será Excluido !", message: "", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Excluir", style: .destructive, handler: okDelete)
        let CancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancelarDelete)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect  = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func okDelete(alertAction: UIAlertAction!) -> Void {
        
        if let indexPath = contatoIndexPath {
            
            let api = ApiContato()
            
            tableView.beginUpdates()
            
            let contatoSelecionado = self.contatos[indexPath.row] as! NSDictionary
            let codContato = contatoSelecionado["codContato"] as! Int
            
            api.deletar(codContato: codContato, completionHandler: { (retono) in
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.contatos.remove(at: indexPath.row)
                
                self.tableView.reloadData()
                
                self.contatoIndexPath = nil
                
                self.tableView.endUpdates()
                
            })
        }
    }
    
    func cancelarDelete(alertAction: UIAlertAction!) {
        contatoIndexPath = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (self.contatoAdcionar)
        {
            if(segue.identifier == "ContatoAcionar") {
                
                let vc = segue.destination as! ContatoViewController
                vc.contato = self.contatos[sender as! Int] as! NSDictionary
                
            }
        }
    }

}
