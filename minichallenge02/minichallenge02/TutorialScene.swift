//
//  TutorialScene.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit


//tela do tutorial
class TutorialScene: SKScene, SKPhysicsContactDelegate {
    var viewController: TutorialViewController?
    var toothbrush = Toothbrush()
    var tartarus:[Tartarus] = []
    var speechBalloon = SKSpriteNode()
    //para identificar que horas a atividade acaba para passar para a próxima tela
    var activityOver = false
    //audios
    var trainSpeech = SKAction.playSoundFileNamed("Trenzinho.m4a", waitForCompletion: true)
    var feedbackSpeech = SKAction.playSoundFileNamed("TutorialFinished.m4a", waitForCompletion: true)
    
    override func didMove(to view: SKView) {
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //adicionando elementos à SKView
        addDino()
        addBackground()
        addDinoTalking()
        addSpeechBalloon()
        addTartarus(count: 1)
        //toca o áudio
        self.run(trainSpeech, completion: addToothbrush)
        
    }
    
    //configurações do background
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "tutorial-scene")
        //posiciona o background ao fundo
        background.zPosition = 0
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //renderizar sem alpha blending para ocupar menos memória (não renderiza pixel por pixel)
        background.blendMode = .replace
        addChild(background)
    }
    
    //adiciona dino à tela
    func addDino(){
        let dino = SKSpriteNode(imageNamed: "dino-tutorial")
        dino.zPosition = 1
        dino.xScale = 0.5
        dino.yScale = 0.5
        //posiciona o dino dependendo do tamanho da tela do dispositivo
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            dino.position = CGPoint(x: -140, y: -55)
        } else{
            //posiciona o dino na esquerda
            dino.position = CGPoint(x:-110, y:-45)
        }
        self.addChild(dino)
    }
    
    //adiciona escova na tela
    func addToothbrush(){
        toothbrush.zPosition = 2
        toothbrush.position = CGPoint(x:220, y:80)
        self.addChild(toothbrush)
    }

    //adiciona instâncias da Classe tártaro em um array e na tela
    func addTartarus(count: Int){
        for i in 0..<count{
            let tartaroTemp:Tartarus = Tartarus(id: i)
            tartaroTemp.addTutorialPosition(sprite: tartaroTemp)
            tartaroTemp.zPosition = 2
            tartarus.append(tartaroTemp)
            print("Id do tártaro: \(tartaroTemp.id)"  )
            self.addChild(tartaroTemp)
        }
    }
    
    //Dino em miniatura para indicar fala
    func addDinoTalking(){
        let dinoTalking = SKSpriteNode(imageNamed: "talking-dino")
        dinoTalking.zPosition = 1
        dinoTalking.xScale = 0.15
        dinoTalking.yScale = 0.15
        //posiciona o dino conforme tamanho da tela do aparelho utilizado (grande ou normal)
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            dinoTalking.position = CGPoint(x: 185, y: -55)
        } else{
            //posiciona o dino na direita
            dinoTalking.position = CGPoint(x:165, y:-45)
        }
        //só falta falar
        addChild(dinoTalking)
    }
    
    //Balão de fala do dino
    func addSpeechBalloon(){
        let speechBalloon = SKSpriteNode(imageNamed: "speech-balloon")
        speechBalloon.zPosition = 1
        speechBalloon.xScale = 0.03
        speechBalloon.yScale = 0.03
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            speechBalloon.position = CGPoint(x: 285, y: 65)
        } else{
            //posiciona o dino na direita
            speechBalloon.position = CGPoint(x:245, y:55)
        }
        self.addChild(speechBalloon)
    }
    
    //permite mover a escova para onde o dedo arrastar
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //faz a escova ir para onde o dedo for
        for touch in touches{
            let location = touch.location(in: self)
            toothbrush.position.x = location.x
            toothbrush.position.y = location.y
        }
    }
    
    //detecção do contato
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA == toothbrush {
            playerCollided(with: nodeB as! SKSpriteNode)

        } else if nodeB == toothbrush {
            playerCollided(with: nodeA as! SKSpriteNode)
        }
    }
    
    //ação do contato
    func playerCollided(with node: SKSpriteNode){
        cleanTartarus(node: node)
        killTartarus(node: node)
        if isActivityOver() {
            print("hora de escovar de verdade")
            //toca áudio de conclusão do tutorial e passa para a tela de atividade ao terminar o áudio
             //completion: aceita somente funções sem parametros e vazias
            run(feedbackSpeech, completion: goToActivityScreen)
        }
    }
    
    func goToActivityScreen(){ //função chamada dentro do playerCollided, dentro da SKAction que toca o áudio
        viewController?.transitionToActivity()
    }
    
    func cleanTartarus(node: SKSpriteNode){
        node.alpha -= 0.25
    }
    
    //se o tártaro estiver transparente, retirar ele da tela
    func killTartarus(node: SKSpriteNode){
      if node.alpha <= 0.0{
        //SKAction garante que o node seja removido na hora certa
        let tartarusDeath = SKAction.run({node.removeFromParent()})
        self.run(tartarusDeath)
          print("Tartarus removed from scene")
          Tartarus.tartarusCount -= 1
      }
    }

    //checa se ainda existem tártaros na tela. Se não existir, hora da recompensa
    func isActivityOver() -> Bool{
        if Tartarus.tartarusCount == 0 {
            activityOver = true
        }
      return activityOver
    }

}
