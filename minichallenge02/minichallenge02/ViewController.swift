//
//  ViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 26/03/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Verifica se já existe um "cadastro" salvo em UserDefalts, caso não exista começa o app na tela de cadastro
        if UserDefaults.standard.string(forKey: "nome") != nil /*&& UserDefaults.standard.string(forKey: "avatar")*/ {
            performSegue(withIdentifier: "deNomePraAvatar", sender: self)
        }else{
            performSegue(withIdentifier: "novoCadastro", sender: self)
        }
    }
}
