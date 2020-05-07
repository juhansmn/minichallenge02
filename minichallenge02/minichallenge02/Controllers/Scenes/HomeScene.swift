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
    //Escova
    let activityButton = SKSpriteNode()
    //Profiles
    let profilesButton = SKSpriteNode(imageNamed: "botaoSelecaoPerfil")
    //Background Image
    let backgroundImage = SKSpriteNode(imageNamed: "CenarioComDinoFalando")
    var backgroundAudio = SKAudioNode()
    
    //Primeira função a ser executada na View Controller.
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        setupButton(button: activityButton, name: "activityButton", height: 300, width: 270, x: 100, y: 0)
        setupButton(button: profilesButton, name: "profilesButton", height: 59.67, width: 104.33, x: -320, y: -150)
        setupBackgroundImage(name: "background")
        setupAudio()
    }
    
    //Configura imagem de fundo
    func setupBackgroundImage(name: String){
        backgroundImage.size = CGSize(width: ScreenSize.width, height: ScreenSize.height)
        backgroundImage.zPosition = 0
        
        self.addChild(backgroundImage)
    }
    
    //Configura os nodes de "botões" customizados.
    func setupButton(button: SKSpriteNode, name: String, height: CGFloat, width: CGFloat, x: Int, y: Int){
        button.name = name
        button.size.height = height
        button.size.width = width
        
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            button.position = CGPoint(x: x, y: y)
        } else{
            button.position = CGPoint(x:x + 50, y: y)
        }
        
        button.zPosition = 1
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
                viewController?.transitionToActivity()
                //será que tem que parar o áudio?
            case "profilesButton":
                //Delegate. Troca para seleção de perfis em Cadastro
                viewController?.transitionToProfiles()
            default:
                break
            }
            backgroundAudio.removeFromParent() //se precisar pausar
        }
    }
}
