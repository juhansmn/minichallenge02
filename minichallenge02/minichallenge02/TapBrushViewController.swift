//
//  TapBrushViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import Foundation
import UIKit

class TapBrushViewController: UIViewController{

    @IBAction func brushTeeth(_ sender: Any) {
        performSegue(withIdentifier: "trainSegue", sender: self)
    }
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func skipTutorial(_ sender: Any) {
        performSegue(withIdentifier: "trainSegue", sender: self)
    //home
    }

}
