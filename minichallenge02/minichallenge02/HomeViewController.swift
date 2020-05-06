//
//  HomeViewController.swift
//  minichallenge02
//
//  Created by Juan Suman on 29/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        let scene = HomeScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }

}
