//
//  TutorialViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit
import SpriteKit

//configura a tela do tutorial
class TutorialViewController: UIViewController, SKViewDelegate{
    //criando uma SKView
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adicionando a view criada acima na tela
        view.addSubview(skView)
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    
        //adicionando SKScene (ActivityScene) à view
        let scene = TutorialScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        scene.scaleMode = .aspectFill
        scene.viewController = self
        skView.presentScene(scene)
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true //para o zPosition funcionar (default é false)
    }
    
    func transitionToActivity() {
        performSegue(withIdentifier: "activitySegue", sender: self)
    }
}
