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
    }
    
    //botao para entrar na gameViewController e cenário de escovar o dente
    @IBAction func escovaDente(_ sender: Any) {
        let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "escovarDente") as! GameViewController
        self.navigationController?.pushViewController(firstVC, animated: true)
    }
}
