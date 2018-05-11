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
    var arrayB = [false, false, false]
    
    @IBOutlet weak var tableView: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = array[indexPath.row]
        cell.detailTextLabel?.text = "info"
        cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton
        
        /*if arrayB[indexPath.row]{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editar = UITableViewRowAction(style: .default, title: "Editar"){action, index in print("editar: " + String(index.row) + " " + self.array[index.row])
            self.performSegue(withIdentifier: "segue1", sender: indexPath)
        }
        
        editar.backgroundColor = UIColor.blue
        
        let delete = UITableViewRowAction(style: .default, title: "Apagar"){action, index in print("apagar: " + String(index.row))
        }
        
        delete.backgroundColor = UIColor.red
        
        return [editar, delete]
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayB[indexPath.row]{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
            arrayB[indexPath.row] = false
        }
        else{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
            arrayB[indexPath.row] = true
        }
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "segue1", sender: tableView)
     }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        /*let alert = UIAlertController(title: "Info", message: array[indexPath.row], preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    */
 
        self.performSegue(withIdentifier: "segue1", sender: tableView)
        
        //print(indexPath.row)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue1"){
            let idx = sender as! IndexPath
            let vcdetalhe = (segue.destination as! VCDetalhe)
            vcdetalhe.cidade = array[idx.row]
        }
    }
    
    @IBAction func unWindFromDetalheGravar(segue: UIStoryboardSegue){
        let details = segue.source as! VCDetalhe
        let cidade:String = details.txtCidade.text!
        print(cidade)
        array.append(cidade)
        tableView .reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
}

