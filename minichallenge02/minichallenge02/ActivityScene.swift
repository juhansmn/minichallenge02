//
//  EscovaDente.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 13/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit
import GameplayKit

//relacionado às mascaras de contato e colisão
struct ColliderType{
    static let Toothbrush: UInt32 = 1
    static let Tartarus: UInt32 = 2
}

//tela de atividade
class ActivityScene: SKScene, SKPhysicsContactDelegate {
    
    //criando uma instância da classe Toothbrush
    var toothbrush = Toothbrush()
    //declarando array de tártaros do tipo igual a da Classe Tartarus
    var tartarus:[Tartarus] = []
    //para identificar que horas a atividade acaba para passar para a próxima tela
    var activityOver = false
    //audio de feedback da ativiade
    var feedbackActivity = SKAction.playSoundFileNamed("ActivityFinished.m4a", waitForCompletion: true)
    
    override func didMove(to view: SKView) {
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //adicionando elementos à SKView
        addBackground()
        addToothbrush()
        addTartarus(count: 6)
    }
    
    //configurações do background
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "dino-activity")
        //posiciona o background ao fundo
        background.zPosition = 0
        //configurando o background para ocupar a tela inteira
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //renderizar sem alpha blending para ocupar menos memória (não renderiza pixel por pixel)
        background.blendMode = .replace
        //adiciona background na scene
        addChild(background)
    }
    
    func addToothbrush(){
        //posição inicial que aparecerá na tela
        toothbrush.zPosition = 1
        toothbrush.position = CGPoint(x:300, y:60)
        self.addChild(toothbrush)
    }

    //adiciona as instâncias da Classe Tartarus em um array de SKSpriteNode e à tela
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
            //nodeB é uma instancia da Classe Tartarus dentro do array tartarus

        } else if nodeB == toothbrush {
            playerCollided(with: nodeA as! SKSpriteNode)
            //nodeA é uma instancia da Classe Tartarus dentro do array tartarus
        }
    }
    
    //ação do contato
    func playerCollided(with node: SKSpriteNode){
        cleanTartarus(node: node)
        killTartarus(node: node)
        if isActivityOver() {
            print("hora da recompensa")
            run(feedbackActivity) //toca áudio de feedback
            //passar para a tela de recompensa
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
            //retirar todas as instancias da classe do array
            tartarus.removeAll()
            print("Quantidade de tártaro no array: \(tartarus.count)")
        }
      return activityOver
    }

}
