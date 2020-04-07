//
//  ViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 26/03/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeText(_ sender: Any) {
        label.text = "Texto alterado!"
    }
}

