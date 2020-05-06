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
        scene.viewController = self
        
        let skView = view as! SKView
        skView.presentScene(scene)
    }
    
    func transitionToProfiles(){
        performSegue(withIdentifier: "profilesSegue", sender: self)
    }
    func transitionToActivity(){
        performSegue(withIdentifier: "activitySegue", sender: self)
    }

}
