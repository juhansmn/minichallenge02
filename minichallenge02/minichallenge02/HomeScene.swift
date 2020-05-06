//
//  HomeScene.swift
//  minichallenge02
//
//  Created by Juan Suman on 29/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene {
    var viewController: HomeViewController?
    let activityButton = SKSpriteNode(imageNamed: "activityButton")
    let profilesButton = SKSpriteNode(imageNamed: "profilesButton")
    let dino = SKSpriteNode(imageNamed: "dino")
    var backgroundAudio = SKAudioNode()
    
    //Primeira função a ser executada na View Controller.
    override func didMove(to view: SKView) {
        setupButton(button: activityButton, name: "activityButton", height: 100, width: 100, x: 100, y: 100)
        setupButton(button: profilesButton, name: "profilesButton", height: 200, width: 200, x: 250, y: 120)
        setupDino()
        setupAudio()
    }
    
    //Configura o node Dino.
    func setupDino(){
        dino.name = "dino"
        dino.size.height = 300
        dino.size.width = 500
        dino.position = CGPoint(x: 600, y: 200)
        self.addChild(dino)
    }
    
    //Configura os nodes de "botões" customizados.
    func setupButton(button: SKSpriteNode, name: String, height: CGFloat, width: CGFloat, x: Int, y: Int){
        button.name = name
        button.size.height = height
        button.size.width = width
        button.position = CGPoint(x: x, y: y)
        self.addChild(button)
    }
    
    //adiciona o audio
    func setupAudio(){
        if let audioURL = Bundle.main.url(forResource: "home", withExtension: "mp3"){
            backgroundAudio = SKAudioNode(url: audioURL)
            self.addChild(backgroundAudio)
        }
    }
    
    //Verifica e trata os contatos na Cena.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            switch touchedNode.name {
            case "activityButton":
                //Delegate. Troca para view de Atividades
                print("Vai para atividade")
                viewController?.transitionToActivity()
                
                //será que tem que parar o áudio?
                backgroundAudio.removeFromParent() //se precisar pausar
            case "profilesButton":
                //Delegate. Troca para seleção de perfis em Cadastro
                print("Vai para seleção de perfis")
                viewController?.transitionToProfiles()
            default:
                break
            }
        }
    }
}
