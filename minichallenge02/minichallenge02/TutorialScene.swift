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
    var tartarus:[Tartarus] = []
    //para identificar que horas a atividade acaba para passar para a próxima tela
    var activityOver = false
    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //adicionando elementos à SKView
        
        addDino()
        addBackground()
        addDinoTalking()
        self.run(SKAction.playSoundFileNamed("2 trenzinho.m4a", waitForCompletion: true), completion: addToothbrush)
        addTartarus(count: 1)
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
        //com o balãozinho?
        let dino = SKSpriteNode(imageNamed: "dino-tutorial")
        //posiciona o dino ao fundo
        dino.zPosition = 1
        dino.xScale = 0.5
        dino.yScale = 0.5
        //dino estava flutuando com a posição "normal"
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            dino.position = CGPoint(x: -140, y: -55)
        } else{
            //posiciona o dino na esquerda
            dino.position = CGPoint(x:-110, y:-45)
        }
        self.addChild(dino)
    }
    
    func addToothbrush(){
        //posição inicial que aparecerá na tela
        toothbrush.zPosition = 2
        toothbrush.position = CGPoint(x:220, y:80)
        self.addChild(toothbrush)
    }

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
    
    func addDinoTalking(){
        let dinoTalking = SKSpriteNode(imageNamed: "dino-fala1")
        dinoTalking.zPosition = 1
        dinoTalking.xScale = 0.15
        dinoTalking.yScale = 0.15
        if DeviceType.isiPhone11orProMax || DeviceType.isiPhone8plus {
            dinoTalking.position = CGPoint(x: 170, y: -55)
        } else{
            //posiciona o dino na direita
            dinoTalking.position = CGPoint(x:155, y:-45)
        }
        
        //só falta falar
        addChild(dinoTalking)
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
    
    
    func goToActivityScreen(){
        //depois dá pra chamar a mudança de tela, quando os dois áudios estiverem juntos
        print("tela de atividade")
    }
    
    //ação do contato
    func playerCollided(with node: SKSpriteNode){
        cleanTartarus(node: node)
        killTartarus(node: node)
        
        if isActivityOver() {
            //toca 4 e 4.1 e passa para atividade
            run(SKAction.playSoundFileNamed("3 conclusao tutorial .m4a", waitForCompletion: true), completion: goToActivityScreen)
            print("hora de escovar de verdade")
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
        if Tartarus.tartarusCount == 1 {
            print("É isso mesmo")
            //adiciona audio 3 - Tutorial
            run(SKAction.playSoundFileNamed("3. É isso mesmo.m4a", waitForCompletion: false))
        }
      }
    }

    //checar se ainda existem tártaros na tela. Se não existir, hora da recompensa
    func isActivityOver() -> Bool{
        if Tartarus.tartarusCount == 0 {
            activityOver = true
        }
      return activityOver
    }

}
