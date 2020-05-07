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
        let scene = HomeScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        scene.viewController = self
        scene.scaleMode = .aspectFill
        
        let skView = view as! SKView
        
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        skView.presentScene(scene)
    }
    
    func transitionToProfiles(){
        performSegue(withIdentifier: "profilesSegue", sender: self)
    }
    func transitionToActivity(){
        let storyboard = UIStoryboard(name: "Atividades", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "escovarDente") as GameViewController
        self.show(viewController, sender: self)
    }

}
