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
    
    //criando uma instância da classe Toothbrush
    var toothbrush = Toothbrush()
    //declarando array de tártaros do tipo igual a da Classe Tartarus
    var tartarus:[Tartarus] = []
    //para identificar que horas a atividade acaba para passar para a próxima tela
    var activityOver = false
    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //adicionando elementos à SKView
        addBackground()
        addToothbrush()
        addTartarus(count: 3)
    }
    
    //configurações do background
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "dino")
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
        toothbrush.position = CGPoint(x:300, y:60)
        addChild(toothbrush)
    }

    //adicionando as instâncias da Classe Tartarus em um array de SKSpriteNode e à tela
    func addTartarus(count: Int){
        for _ in 0..<count{
            let tartaroTemp:Tartarus = Tartarus()
            tartarus.append(tartaroTemp)
            
            addChild(tartaroTemp)
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
        if node.name == "Tartarus" {
            cleanTartarus(node: node)
            killTartarus(node: node)
            if isActivityOver() {
                print("hora da recompensa")
            }
        }
    }
    
    //não consegui colocar na Classe Tartarus e chamar aqui
    func cleanTartarus(node: SKSpriteNode){
        node.alpha -= 0.25
    }
    
    func killTartarus(node: SKSpriteNode){
        if node.alpha <= 0.0{
            node.removeFromParent()
            print("Tartarus removed")
            Tartarus.tartarusCount -= 1
        }
    }
    
    func isActivityOver() -> Bool{
        if Tartarus.tartarusCount == 0 {
            activityOver = true
        }
        return activityOver
    }
    
    
}
