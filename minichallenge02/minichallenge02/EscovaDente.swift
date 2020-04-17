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
    static let Escova: UInt32 = 1
    static let Tartaro: UInt32 = 2
}

class EscovaDente: SKScene, SKPhysicsContactDelegate {
    
    //declaração da variável da escova e usando a Classe Escova
    var toothbrush = Toothbrush()
    //declarando array de tártaros
    var tartarus:[Tartarus] = []
    
    var imagensTartaros = ["tartaro1","tartaro2", "tartaro3"]
    
    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        addBackground()
        
        addToothbrush()
        addTartarus(count: 3)
        //addTartaro(quantidade: 3)
    }
    
    func addBackground(){
        //imagem de fundo
        let background = SKSpriteNode(imageNamed: "dino")
        background.zPosition = 0 //colocando no fundo
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) //background ocupa tela inteira
        background.blendMode = .replace //relacionado com memória (renderizar sem alpha blending)
        addChild(background) //adiciona background na scene
    }
    
    func addToothbrush(){
        //escova de dente
        //escova.name = "Escova"
//        escova.escovaPhysics(sprite: escova)
//        escova.positionEscova(sprite: escova)
        toothbrush.position = CGPoint(x:300, y:60) //tem que estar aqui, e não na classe
        addChild(toothbrush) //alguns usam o self.addChild self = instancia atual da classe
    }

    func addTartarus(count: Int){
        for _ in 0..<count{
            let tartaroTemp:Tartarus = Tartarus()
            tartarus.append(tartaroTemp)
            
            addChild(tartaroTemp)
        }
    }
    
    
    func addTartaro(quantidade: Int){
        let tartaros = tartaroCollection(count: quantidade) //count determina quantidade de tártaros
        for tartaro in tartaros{
            addChild(tartaro)
        }
    }
    
    
    
    //adicionar vários tártaros de uma vez na array de sprites -> nao vai ter isso com o a classe
    func tartaroCollection(count: Int) -> [SKSpriteNode]{
        var tartaros = [SKSpriteNode]() //precisava disso lá em cima e aqui só preencher
        
        for _ in 0..<count{
            //randomizar a escolha da imagem para o tártaro como GameplayKit
            imagensTartaros = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: imagensTartaros) as! [String]
            
            let tartaro = SKSpriteNode(imageNamed: imagensTartaros[0])
            tartaro.name = "Tartarus"
//            positionTartaros(sprite: tartaro)
//            tartaroPhysics(sprite: tartaro)

            tartaros.append(tartaro)
        }
        
        return tartaros
    }
    
//    func tartaroPhysics(sprite: SKSpriteNode){
//        //colisão
//        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
//        sprite.physicsBody?.affectedByGravity = false
//        sprite.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
//        sprite.physicsBody?.categoryBitMask = ColliderType.Tartaro
//    }
//
//    func positionTartaros(sprite: SKSpriteNode){
//        sprite.zPosition = 1 //deixa acima do background
//
//        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
//        let randomPosition = GKRandomDistribution(lowestValue: -200, highestValue: 200)
//        let position = CGFloat(randomPosition.nextInt())
//        sprite.position = CGPoint(x: position, y: 0)
//    }


    
    
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
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Toothbrush"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Toothbrush" && secondBody.node?.name == "Tartarus"{
            // tartaro.alpha para diminuir a opacidade, 0.0 = transparente
            print("contato feito")
            //uma bela gambiarra, precisava tirar mas o collisionTartaro nao funcionou
            secondBody.node?.alpha -= 0.25
            if secondBody.node!.alpha <= 0.0 {
                secondBody.node?.removeFromParent()
                Tartarus.cont -= 1
                if Tartarus.cont == 0 {
                    print("removeu tudo")
                }
            }
            
            //storyboard reference pra chamar a recompensa quando todos os nodes forem removidos
            
 
        }
        
//COMO ERA ANTES
//        if firstBody.node?.name == "Escova" && secondBody.node?.name == "Tartaro1"{
//            // tartaro.alpha para diminuir a opacidade, 0.0 = transparente
//            print("contato feito")
//            //pra cada contato, diminuir 0.25 da opacidade
//
//            tartaro1.alpha -= 0.25
//            if tartaro1.alpha == 0.0{ //só funciona quando diminuir 0.25, e nao 0.10, 0.20
//                //isHidden?
//                tartaro1.removeFromParent()
//
//            }
    }
    
    //nao funcionou porque nao consigo pegar o elemento da array
//    func collisionTartaro(spritesCollection: [SKSpriteNode]){
//        for sprite in spritesCollection{
//            sprite.alpha -= 0.25
//            if sprite.alpha <= 0.0 {
//                sprite.removeFromParent()
//            }
//        }
//    }
    
    //passar para a tela de recompensa
    
}
