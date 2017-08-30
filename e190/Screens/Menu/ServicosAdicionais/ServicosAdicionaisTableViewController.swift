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
    @IBOutlet weak var label_pessoal: UILabel!
    @IBOutlet weak var label_veicular: UILabel!
    @IBOutlet weak var label_pronto_atendimento: UILabel!
    @IBOutlet weak var label_medico: UILabel!
    @IBOutlet weak var label_ambulancia: UILabel!
    
    
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
        
        let cellSize: CGFloat = 118
        
        if indexPath.row == 0 {
            
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_pessoal.isHidden = false
                tableView.rowHeight = cellSize
            }
            else
            {
                dataCellexpanded = true
                label_pessoal.isHidden = true
                tableView.rowHeight = 250
            }
        }
        if indexPath.row == 1 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_veicular.isHidden = false
            }
            else
            {
                dataCellexpanded = true
                label_veicular.isHidden = true
            }
        }
        if indexPath.row == 2 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_pronto_atendimento.isHidden = false
            }
            else
            {
                dataCellexpanded = true
                label_pronto_atendimento.isHidden = true
            }
        }
        if indexPath.row == 3 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_medico.isHidden = false
            }
            else
            {
                dataCellexpanded = true
                label_medico.isHidden = false
            }
        }
        if indexPath.row == 4 {
            if dataCellexpanded {
                
                dataCellexpanded = false
                label_ambulancia.isHidden = false
            }
            else
            {
                dataCellexpanded = true
                label_ambulancia.isHidden = true
            }
        }
    
        tableView.beginUpdates()
        tableView.endUpdates()
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    
//        let cellSize: CGFloat = 118
//        
//        if tableView.tag == indexPath.row
//        {
//            if dataCellexpanded {
//                return 250
//            }
//            else
//            {
//                return cellSize
//            }
//        }
////        if tableView.tag == indexPath.row
////        {
////            if dataCellexpanded {
////                return 250
////            }
////            else
////            {
////                return cellSize
////            }
////        }
////        if tableView.tag == indexPath.row
////        {
////            if dataCellexpanded {
////                return 250
////            }
////            else
////            {
////                return cellSize
////            }
////        }
////        if tableView.tag == indexPath.row
////        {
////            if dataCellexpanded {
////                return 250
////            }
////            else
////            {
////                return cellSize
////            }
////        }
////        if tableView.tag == indexPath.row
////        {
////            if dataCellexpanded {
////                return 250
////            }
////            else
////            {
////                return cellSize
////            }
////        }
//        return cellSize
//    }
}
