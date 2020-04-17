//
//  GameViewController.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 13/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //criando uma SKView
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adicionando a view criada lá em cima
        view.addSubview(skView)
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    
        //adicionando SKScene (EscovaDente) à view
        let scene = EscovaDente(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)) //Seria bom colocar UISCreen.main.... em um arquivo separado, junto com as outras configurações de tamanho
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true //para o zPosition funcionar (default é false)
    }
    
}