//
//  CadastroNomeView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 06/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class CadastroNomeView: UIViewController {
    
    @IBOutlet weak var nomeDaCriancaTextField: UITextField!

    @IBAction func avancarAction(_ sender: Any) {
        let nome = nomeDaCriancaTextField.text

        UserDefaults.standard.set(nome, forKey: "nome")

        performSegue(withIdentifier: "deNomePraAvatar", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
