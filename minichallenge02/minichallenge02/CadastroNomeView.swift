//
//  CadastroNomeView.swift
//  minichallenge02
//
//  Created by Beatriz da Silva on 06/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit
var usuario = Usuario()

class CadastroNomeView: UIViewController {
    
    @IBOutlet weak var nomeDaCriancaTextField: UITextField!

    @IBAction func avancarAction(_ sender: Any) {
        guard let nome = nomeDaCriancaTextField.text , !nome.isEmpty else {return}
        
        usuario.nome = nome
        
        performSegue(withIdentifier: "deNomePraAvatar", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
