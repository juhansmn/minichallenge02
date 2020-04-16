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
    
    //declarando a variável da escova
    var escova = SKSpriteNode()
    //precisava declarar aqui a váriavel da array de tartaros também, pra poder acessar na parte de colisão. Ou acessar na colisão de outra forma...
    var imagensTartaros = ["tartaro1","tartaro2", "tartaro3"]
    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        addBackground()
        
        addEscova()
        
        addTartaro()
    }
    
    //dúvidas: nao é ruim um monte de função vazia? que nao recebe parametro e nem retorna nada?
    func addEscova(){
        //escova de dente
        escova = SKSpriteNode(imageNamed: "Escova")
        escova.name = "Escova"
        
        positionEscova(sprite: escova)
        escovaPhysics(sprite: escova)
        
        self.addChild(escova) //alguns usam o self.addChild
    }
    
    
    
    func addBackground(){
        //imagem de fundo
        let background = SKSpriteNode(imageNamed: "Background")
        background.zPosition = 0 //colocando no fundo
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) //background ocupa tela inteira
        background.blendMode = .replace //relacionado com memória (renderizar sem alpha blending)
        addChild(background) //adiciona background na scene
    }
    
    //adicionar vários tártaros de uma vez na array de sprites
    func tartaroCollection(count: Int) -> [SKSpriteNode]{
        var tartaros = [SKSpriteNode]() //precisava disso lá em cima e aqui só preencher
        
        for _ in 0..<count{
            //randomizar a escolha da imagem para o tártaro como GameplayKit
            imagensTartaros = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: imagensTartaros) as! [String]
            
            let tartaro = SKSpriteNode(imageNamed: imagensTartaros[0])
            tartaro.name = "Tartaro"
            positionTartaros(sprite: tartaro)
            tartaroPhysics(sprite: tartaro)

            tartaros.append(tartaro)
        }
        return tartaros
    }
    
    
    
    func addTartaro(){
        let tartaros = tartaroCollection(count: 5) //count determina quantidade de tártaros
        for tartaro in tartaros{
            addChild(tartaro)
        }
    }
    
    func positionTartaros(sprite: SKSpriteNode){
        sprite.zPosition = 1 //deixa acima do background
        
        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
        let randomPosition = GKRandomDistribution(lowestValue: -200, highestValue: 200)
        let position = CGFloat(randomPosition.nextInt())
        sprite.position = CGPoint(x: position, y: 0)
    }
    
    func positionEscova(sprite: SKSpriteNode){
        sprite.zPosition = 1
        sprite.position = CGPoint(x:-100, y:0)
        //para diminuir o tamanho da escova
        sprite.xScale = 0.5
        sprite.yScale = 0.5
    }
    
    func escovaPhysics(sprite: SKSpriteNode){
        //parte física
        sprite.physicsBody = SKPhysicsBody(rectangleOf: escova.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = true //permite que a escova interaja com o tartaro
        sprite.physicsBody?.allowsRotation = false //nao deixa ficar girando enquanto mexe
        
        //colisão
        sprite.physicsBody?.categoryBitMask = ColliderType.Escova
        sprite.physicsBody?.collisionBitMask = ColliderType.Tartaro
        sprite.physicsBody?.contactTestBitMask = ColliderType.Tartaro
    }
    
    func tartaroPhysics(sprite: SKSpriteNode){
        //colisão
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        sprite.physicsBody?.categoryBitMask = ColliderType.Tartaro
    }
    
    
    //permite mover a escova para onde o dedo arrastar
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //faz a escova ir para onde o dedo for
        for touch in touches{
            let location = touch.location(in: self)
            escova.position.x = location.x
            escova.position.y = location.y
        }
        
    }
    
    //detectando contato
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Escova"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Escova" && secondBody.node?.name == "Tartaro"{
            // tartaro.alpha para diminuir a opacidade, 0.0 = transparente
            print("contato feito")
            //uma bela gambiarra, precisava tirar mas o collisionTartaro nao funcionou
            secondBody.node?.alpha -= 0.22
            if secondBody.node!.alpha <= 0.0 {
                secondBody.node?.removeFromParent()
            }
 
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
    
}
