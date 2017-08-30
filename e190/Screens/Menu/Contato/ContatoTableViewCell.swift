//
//  ContatoTableViewCell.swift
//  e190
//
//  Created by Marcelo Roberto Pavani on 31/07/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit

class ContatoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var text_nome: UILabel!
    @IBOutlet weak var text_telefone: UILabel!
    @IBOutlet weak var text_email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
