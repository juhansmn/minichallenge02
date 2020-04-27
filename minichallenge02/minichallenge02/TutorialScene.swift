//
//  TutorialScene.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 24/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene, SKPhysicsContactDelegate {
    
    //criando uma instância da classe Toothbrush
    var toothbrush = Toothbrush()
    //declarando array de tártaros do tipo igual a da Classe Tartarus
    var tartarus1 = Tartarus(id: 0)
    var tartarus2 = Tartarus(id: 1)
    //para identificar que horas a atividade acaba para passar para a próxima tela
    var activityOver = false
    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //adicionando elementos à SKView
        addDino()
        addBackground()
        addToothbrush()
        addTartarus()
    }
    
    //configurações do background
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "fundo-tutorial")
        //posiciona o background ao fundo
        background.zPosition = 0
        //configurando o background para ocupar a tela inteira
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //renderizar sem alpha blending para ocupar menos memória (não renderiza pixel por pixel)
        background.blendMode = .replace
        //adiciona background na scene
        addChild(background)
    }
    
    func addDino(){
        let dino = SKSpriteNode(imageNamed: "dino-tutorial")
        //posiciona o dino ao fundo
        dino.zPosition = 1
        dino.xScale = 0.5
        dino.yScale = 0.5
        //posiciona o dino na esquerda
        dino.position = CGPoint(x:-110, y:-45)
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            dino.position = CGPoint(x: -140, y: -55)
        }
        self.addChild(dino)
    }
    
    func addToothbrush(){
        //posição inicial que aparecerá na tela
        toothbrush.zPosition = 2
        toothbrush.position = CGPoint(x:220, y:60)
        self.addChild(toothbrush)
    }

    //adicionando as instâncias da Classe Tartarus em um array de SKSpriteNode e à tela
    func addTartarus(){
        tartarus1.zPosition = 2
        tartarus1.addTutorialPosition(sprite: tartarus1)
        self.addChild(tartarus1)
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
            //nodeB é uma instancia da Classe Tartarus dentro do array tartarus
            //qual é o id do nodeB

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
            //passar para a tela de recompensa
        
        }
    }
    
    //não consegui colocar na Classe Tartarus e chamar aqui, preciso saber qual instancia está sendo tocada dentro do array e acessar as propriedades do elemento
    func cleanTartarus(node: SKSpriteNode){
        node.alpha -= 0.25
    }
    
    //se o tártaro estiver transparente, retirar ele da tela
    func killTartarus(node: SKSpriteNode){
      if node.alpha <= 0.0{
        let tartarusDeath = SKAction.run({node.removeFromParent()})
        self.run(tartarusDeath)
          print("Tartarus removed from scene")
          Tartarus.tartarusCount -= 1
      }
    }

    //checar se ainda existem tártaros na tela. Se não existir, hora da recompensa
    func isActivityOver() -> Bool{
        if Tartarus.tartarusCount == 0 {
            activityOver = true
            //retirar todas as instancias da classe do array
//            tartarus.removeAll()
//            print("Quantidade de tártaro no array: \(tartarus.count)")
        }
      return activityOver
    }

}
