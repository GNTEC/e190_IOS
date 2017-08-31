//
//  ServicosAdicionaisTableViewController.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 28/08/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class ServicosAdicionaisTableViewController: UITableViewController {

    private var dataCellexpanded:Bool = false
    private var cellSelected: Int = 0
    
    @IBOutlet weak var label_pessoal: UILabel!
    @IBOutlet weak var label_pessoal_inf: UILabel!
    
    @IBOutlet weak var label_veicular: UILabel!
    @IBOutlet weak var label_veicular_inf: UILabel!
    
    @IBOutlet weak var label_pronto_atendimento: UILabel!
    @IBOutlet weak var label_pronto_atendimento_inf: UILabel!
    
    @IBOutlet weak var label_medico: UILabel!
    @IBOutlet weak var label_medico_inf: UILabel!
    
    @IBOutlet weak var label_ambulancia: UILabel!
    @IBOutlet weak var label_ambulancia_inf: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func voltar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
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
        return 5
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        cellSelected = indexPath.row
        
        if indexPath.row == 0 {
            
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_pessoal.isHidden = false
                label_pessoal_inf.isHidden = true
            }
            else
            {
                dataCellexpanded = true
                label_pessoal.isHidden = true
                label_pessoal_inf.isHidden = false
            }
        }
        if indexPath.row == 1 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_veicular.isHidden = false
                label_veicular_inf.isHidden = true
            }
            else
            {
                dataCellexpanded = true
                label_veicular.isHidden = true
                label_veicular_inf.isHidden = false
            }
        }
        if indexPath.row == 2 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_pronto_atendimento.isHidden = false
                label_pronto_atendimento_inf.isHidden = true
            }
            else
            {
                dataCellexpanded = true
                label_pronto_atendimento.isHidden = true
                label_pronto_atendimento_inf.isHidden = false
            }
        }
        if indexPath.row == 3 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_medico.isHidden = false
                label_medico_inf.isHidden = true
            }
            else
            {
                dataCellexpanded = true
                label_medico.isHidden = true
                label_medico_inf.isHidden = false
            }
        }
        if indexPath.row == 4 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_ambulancia.isHidden = false
                label_ambulancia_inf.isHidden = true
            }
            else
            {
                dataCellexpanded = true
                label_ambulancia.isHidden = true
                label_ambulancia_inf.isHidden = false
            }
        }
    
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let cellSize: CGFloat = 118
        let cellSizeExpand: CGFloat = 340
        
        
        if  indexPath.row == 0 && cellSelected == 0
        {
            if dataCellexpanded {
                return cellSizeExpand
            }
            else
            {
                return cellSize
            }
        }
        if indexPath.row == 1 && cellSelected == 1
        {
            if dataCellexpanded {
                return 430
            }
            else
            {
                return cellSize
            }
        }
        if indexPath.row == 2 && cellSelected == 2
        {
            if dataCellexpanded {
                return cellSizeExpand
            }
            else
            {
                return cellSize
            }
        }
        if indexPath.row == 3 && cellSelected == 3
        {
            if dataCellexpanded {
                return cellSizeExpand
            }
            else
            {
                return cellSize
            }
        }
        if indexPath.row == 4 && cellSelected == 4
        {
            if dataCellexpanded {
                return cellSizeExpand
            }
            else
            {
                return cellSize
            }
        }
        return cellSize
    }
}
