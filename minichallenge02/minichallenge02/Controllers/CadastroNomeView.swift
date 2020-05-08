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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesKeyboard()
    }
    
    @IBAction func avancarAction(_ sender: Any) {
        if let nome = nomeDaCriancaTextField.text, !nome.isEmpty {
            usuario.nome = nome
        }
        else{
            usuario.nome = "Criança"
        }
    
        performSegue(withIdentifier: "deNomePraAvatar", sender: self)
    }
    
}

extension UIViewController{
    func hidesKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
