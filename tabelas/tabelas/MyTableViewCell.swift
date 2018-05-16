//
//  MyTableViewCell.swift
//  tabelas
//
//  Created by DocAdmin on 5/16/18.
//  Copyright © 2018 DocAdmin. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblSubTitulo: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
}
