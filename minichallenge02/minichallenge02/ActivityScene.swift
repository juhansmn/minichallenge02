//
//  EscovaDente.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 13/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ColliderType{
    static let Toothbrush: UInt32 = 1
    static let Tartarus: UInt32 = 2
}

class ActivityScene: SKScene, SKPhysicsContactDelegate {
    var viewController: GameViewController?
    var toothbrush = Toothbrush()
    var tartarus:[Tartarus] = []
    var activityOver = false
    var feedbackActivityAudio = SKAudioNode()
    //espera o áudio acabar de tocar para passar de tela
    var sequenceFeedback = SKAction.sequence([SKAction.play(),SKAction.wait(forDuration: 19.0)])
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        addBackground()
        addToothbrush()
        addTartarus(count: 6)
        setupFeedbackAudio()
    }
    
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "dino-activity")
        background.zPosition = 0
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //renderizar sem alpha blending para ocupar menos memória (não renderiza pixel por pixel)
        background.blendMode = .replace
        addChild(background)
    }
    
    func addToothbrush(){
        toothbrush.zPosition = 1
        toothbrush.position = CGPoint(x:300, y:60)
        self.addChild(toothbrush)
    }

    func addTartarus(count: Int){
        for i in 0..<count{
            let tartaroTemp:Tartarus = Tartarus(id: i)
            tartaroTemp.addTartarusPosition(sprite: tartaroTemp)
            tartaroTemp.zPosition = 1
            tartarus.append(tartaroTemp)
            print("Id do tártaro: \(tartaroTemp.id)"  )
            self.addChild(tartaroTemp)
        }
    }
    
    func setupFeedbackAudio(){
        if let feedbackActivityAudioURL = Bundle.main.url(forResource: "ActivityFinished", withExtension: "m4a"){
            feedbackActivityAudio = SKAudioNode(url: feedbackActivityAudioURL)
            feedbackActivityAudio.autoplayLooped = false
            self.addChild(feedbackActivityAudio)
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
    
    //detectando contato
    func didBegin(_ contact: SKPhysicsContact) {
        //nodes que vao se tocar, tártaro e escova podem ser tanto A quanto B
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeA == toothbrush {
            playerCollided(with: nodeB as! SKSpriteNode)

        } else if nodeB == toothbrush {
            playerCollided(with: nodeA as! SKSpriteNode)
        }
    }
    
    //ações a partir do contato
    func playerCollided(with node: SKSpriteNode){        
        cleanTartarus(node: node)
        killTartarus(node: node)
        if isActivityOver() {
            //run(feedbackActivity) //toca áudio de feedback
            //passar para a tela de recompensa
             feedbackActivityAudio.run(sequenceFeedback, completion: {
                self.viewController?.transitionToReward()
            })
            
        }
    }
    
    func cleanTartarus(node: SKSpriteNode){
        node.alpha -= 0.17
    }
    
    //se o tártaro estiver transparente, retirar ele da tela e do array
    func killTartarus(node: SKSpriteNode){
      if node.alpha <= 0.0 {
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
            tartarus.removeAll()
            print("Quantidade de tártaro no array: \(tartarus.count)")
        }
      return activityOver
    }

}
