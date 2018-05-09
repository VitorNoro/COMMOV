//
//  ViewController.swift
//  commov
//
//  Created by DocAdmin on 5/9/18.
//  Copyright © 2018 DocAdmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: properties
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var lbl1: UILabel!
    
    //MARK: actions
    @IBAction func clickBtn1(_ sender: UIButton) {
        lbl1.text = "Escreva na caixa de texto"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

