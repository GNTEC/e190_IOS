//
//  SideMenuTableView.swift
//  e190
//
//  Created by User on 09/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit


class SideMenuTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        if indexPath.row == 4 {
            
            let mainStoryboard = UIStoryboard(name: "EmergenciaMedica", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "EMedica") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 9 {
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
    }
}
