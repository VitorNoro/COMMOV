//
//  ViewController.swift
//  CoreData
//
//  Created by DocAdmin on 5/16/18.
//  Copyright © 2018 ei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var delegate : AppDelegate?
    
    @IBOutlet weak var textoPais1: UITextField!
    @IBOutlet weak var textoCidade1: UITextField!
    @IBOutlet weak var textoPais2: UITextField!
    @IBOutlet weak var textoCidadeDoPais: UITextField!
    @IBOutlet weak var labelCidadesDoPais: UILabel!
    @IBOutlet weak var textoCidade2: UITextField!
    @IBOutlet weak var labelPaisDaCidade: UILabel!
    @IBOutlet weak var textoPaisAntigo: UITextField!
    @IBOutlet weak var textoPaisNovo: UITextField!
    @IBOutlet weak var label3: UILabel!
    
    @IBAction func addPais(_ sender: UIButton) {
        Pais.insert(nome: textoPais1.text!, appDel: delegate!)
        textoPais1.text = ""
    }
    
    @IBAction func updatePais(_ sender: UIButton) {
        Pais.update(nomeAntigo: textoPaisAntigo.text!, nomeNovo: textoPaisNovo.text!, appDel: delegate!)
    }
    
    @IBAction func todasAsCidades(_ sender: Any) {
        var result:String! = ""
        
        if let arr = Cidade.getAll(appDel: delegate!){
            for c:Cidade in arr {
                result = result + ";" + c.nome!
                if let p:Pais = c.tem_pais {
                    result = result + "(" + p.nome! + ")"
                }
            }
        }
        
        label3.text = result
    }
    
    @IBAction func allPaises(_ sender: Any) {
        var result:String! = ""
        if let arr = Pais.getAll(appDel: delegate!){
            for p:Pais in arr {
                result = result + ";" + p.nome!
            }
        }
        
        label3.text = result
    }
    
    @IBAction func removerPais(_ sender: Any) {
        Pais.delete(nome: textoPais1.text!, appDel: delegate!)
    }
    
    @IBAction func adicionarCidade(_ sender: Any) {
        Cidade.insert(nome: textoCidade1.text!, nomePais: textoPais2.text!, populacao: 1000, appDel: delegate!)
        textoCidade1.text = ""
        textoPais2.text = ""
    }
    
    @IBAction func getPaisDaCidade(_ sender: Any) {
        if let c:Cidade = Cidade.getByNome(nome: textoCidade2.text!, appDel: delegate!){
            labelPaisDaCidade.text = c.tem_pais?.nome
        } else{
            labelPaisDaCidade.text = "Cidade nao existe"
        }
    }
    
    @IBAction func getCidadesDoPais(_ sender: Any) {
        if let p:Pais = Pais.getByNome(nome: textoCidadeDoPais.text!, appDel: delegate!){
            var result:String = ""
            print(p.tem_cidade!.count)
            for c in p.tem_cidade! as! Set<Cidade> {
                result = result + c.nome!
                print(c.nome!)
            }
                labelCidadesDoPais.text = result
        } else{
            labelCidadesDoPais.text = "Nao ha"
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = UIApplication.shared.delegate as? AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

}

