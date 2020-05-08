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
    var guideAudio = SKAudioNode()
    var feedbackAudio = SKAudioNode()
    //sequencia de tocar o áudio e adicionar a escova
    let sequenceBrush = SKAction.sequence([SKAction.play(),SKAction.wait(forDuration: 4.0)])
    let sequenceFeedback = SKAction.sequence([SKAction.play(),SKAction.wait(forDuration: 7.0)])

    
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
        guideAudioSetup()
        feedbackAudioSetup()
        //toca o áudio e apresenta a escova após o áudio acabar
        guideAudio.run(sequenceBrush, completion: {
            self.addToothbrush()
        })

    }
    
    //configurações do background
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "tutorial-scene")
        //posiciona o background ao fundo
        background.zPosition = 0
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //renderizar sem alpha blending para ocupar menos memória (não renderiza pixel por pixel)
        background.blendMode = .replace
        self.addChild(background)
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
        self.addChild(dinoTalking)
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
    
    //Configuração do Audio
    func guideAudioSetup(){
        if let guideAudioURL = Bundle.main.url(forResource: "Trenzinho", withExtension: "m4a"){
            guideAudio = SKAudioNode(url: guideAudioURL)
            guideAudio.autoplayLooped = false
            self.addChild(guideAudio)
        }
    }
    
    //Configuração do Audio
    func feedbackAudioSetup(){
        if let feedbackAudioURL = Bundle.main.url(forResource: "TutorialFinished", withExtension: "m4a"){
            feedbackAudio = SKAudioNode(url: feedbackAudioURL)
            feedbackAudio.autoplayLooped = false
            self.addChild(feedbackAudio)
        }
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
             feedbackAudio.run(sequenceFeedback, completion: {
                self.goToActivityScreen()
            })
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
