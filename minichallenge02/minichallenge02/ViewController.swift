//
//  ViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 26/03/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
<<<<<<< Updated upstream
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var actionButton: UIButton!
=======

    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var nomeDaCriancaTextField: UITextField!
   
    @IBAction func avancarAction(_ sender: Any) {
        let nome = nomeDaCriancaTextField.text
        
        UserDefaults.standard.set(nome, forKey: "nome")
        
        performSegue(withIdentifier: "deNomePraAvatar", sender: self)
    }
>>>>>>> Stashed changes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let nomeAnterior = UserDefaults.standard.value(forKey: "nome") else { return }
        
//        nomeLabel.text = nomeAnterior as? String
        
    }

    @IBAction func changeText(_ sender: Any) {
        label.text = "Texto alterado!"
    }
}

