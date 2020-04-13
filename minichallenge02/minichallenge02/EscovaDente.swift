//
//  EscovaDente.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 13/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit

struct ColliderType{
    static let Escova: UInt32 = 1
    static let Tartaro: UInt32 = 2
}

class EscovaDente: SKScene, SKPhysicsContactDelegate {
    
    //declarando a variável da escova
    var escova = SKSpriteNode(imageNamed: "Escova")
    var tartaro = SKSpriteNode(imageNamed: "Tartaro")
    
    override func didMove(to view: SKView) {
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //imagem de fundo
        let background = SKSpriteNode(imageNamed: "Background")
        background.zPosition = 0 //colocando no fundo
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) //background ocupa tela inteira
        addChild(background) //adiciona background na scene
        
        //escova de dente
        
        escova.name = "Escova"
        escova.anchorPoint = CGPoint(x: 0.5, y: 0.5) //ancora no centro da tela
        escova.position = CGPoint(x: -100, y: 0) //posiciona escova no canto esq da tela
        escova.zPosition = 2 //em cima do background e do tartaro
        //tamanho
        escova.xScale = 0.25
        escova.yScale = 0.25
        //parte física
        escova.physicsBody = SKPhysicsBody(rectangleOf: escova.size)
        escova.physicsBody?.affectedByGravity = false
        escova.physicsBody?.isDynamic = true //outro sprite nao vai poder mexer nele
        escova.physicsBody?.allowsRotation = false //nao deixa ficar girando enquanto mexe
        //colisão
        escova.physicsBody?.categoryBitMask = ColliderType.Escova
        escova.physicsBody?.collisionBitMask = ColliderType.Tartaro
        escova.physicsBody?.contactTestBitMask = ColliderType.Tartaro
        addChild(escova) //alguns usam o self.addChild
        
        //tartaro
        tartaro.name = "Tartaro"
        tartaro.anchorPoint = CGPoint(x:0.5, y:0.5)
        tartaro.position = CGPoint(x:100, y:0)
        tartaro.zPosition = 1
        //tamanho
        tartaro.xScale = 0.5
        tartaro.yScale = 0.5
        //colisão
        tartaro.physicsBody = SKPhysicsBody(rectangleOf: tartaro.size)
        tartaro.physicsBody?.affectedByGravity = false
        tartaro.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        tartaro.physicsBody?.categoryBitMask = ColliderType.Tartaro

        self.addChild(tartaro)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //faz a escova ir para onde o dedo for
        for touch in touches{
            let location = touch.location(in: self)
            escova.position.x = location.x
            escova.position.y = location.y
        }
        
    }
    
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
            print("contato feito")
            tartaro.removeFromParent()
            //existe como fazer um if enemy for removido, passa para a próxima tela?
            //existe transição na hora de remover?
            //seria melhor não removar e só mudar a opacidade?
            
        }
       
        
    }
}
