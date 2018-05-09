//
//  ViewController.swift
//  tabelas
//
//  Created by DocAdmin on 5/9/18.
//  Copyright © 2018 DocAdmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var array = ["Lisboa", "Porto", "Viseu"]
    var arrayAdd = ["L", "P", "V"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = array[indexPath.row]
        cell.detailTextLabel?.text = arrayAdd[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editar = UITableViewRowAction(style: .default, title: "Editar"){action, index in print("editar: " + String(index.row) + " " + self.array[index.row])
        }
        
        editar.backgroundColor = UIColor.blue
        
        let delete = UITableViewRowAction(style: .default, title: "Apagar"){action, index in print("apagar: " + String(index.row))
        }
        
        delete.backgroundColor = UIColor.red
        
        return [editar, delete]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

