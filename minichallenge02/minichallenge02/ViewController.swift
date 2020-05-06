//
//  ViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 26/03/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    public var usuario: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nome.text = usuario?.nome
    }

    @IBOutlet weak var nome: UILabel!
}
