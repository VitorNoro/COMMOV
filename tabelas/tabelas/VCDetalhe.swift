//
//  VCDetalhe.swift
//  tabelas
//
//  Created by DocAdmin on 5/11/18.
//  Copyright © 2018 DocAdmin. All rights reserved.
//

import UIKit

class VCDetalhe: UIViewController{
    var cidade : String = ""
    var id_cidade : Int = -1
    
    @IBOutlet weak var txtCidade: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false;
        txtCidade.text = cidade
        
        print(cidade)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(txtCidade.text == ""){
            print("Nome tem de ser preenchido")
            return false
        }
        return true
    }
}
