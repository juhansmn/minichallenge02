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
    var escova = SKSpriteNode()
    var tartaro = SKSpriteNode()
    var tartaro1 = SKSpriteNode()

    
    override func didMove(to view: SKView) {
        
        //centralizando anchorpoint da view
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        
        //imagem de fundo
        let background = SKSpriteNode(imageNamed: "Background")
        background.zPosition = 0 //colocando no fundo
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) //background ocupa tela inteira
        background.blendMode = .replace //relacionado com memória (renderizar sem alpha blending)
        addChild(background) //adiciona background na scene
        
        //escova de dente
        escova = SKSpriteNode(imageNamed: "Escova")
        escova.name = "Escova"
        escova.anchorPoint = CGPoint(x: 0.5, y: 0.5) //ancora no centro da tela
        escova.position = CGPoint(x: -100, y: 0) //posiciona escova no canto esq da tela
        escova.zPosition = 1 //em cima do background e do tartaro
        //tamanho
        escova.xScale = 0.5
        escova.yScale = 0.5
        //parte física
        escova.physicsBody = SKPhysicsBody(rectangleOf: escova.size)
        escova.physicsBody?.affectedByGravity = false
        escova.physicsBody?.isDynamic = true //permite que a escova interaja com o tartaro
        escova.physicsBody?.allowsRotation = false //nao deixa ficar girando enquanto mexe
        //colisão
        escova.physicsBody?.categoryBitMask = ColliderType.Escova
        escova.physicsBody?.collisionBitMask = ColliderType.Tartaro
        escova.physicsBody?.contactTestBitMask = ColliderType.Tartaro
        self.addChild(escova) //alguns usam o self.addChild
        
        //tartaro
        tartaro = SKSpriteNode(imageNamed: "Tartaro")
        tartaro.name = "Tartaro"
        tartaro.anchorPoint = CGPoint(x:0.5, y:0.5)
        tartaro.position = CGPoint(x:100, y:0)
        tartaro.zPosition = 1

        //colisão
        tartaro.physicsBody = SKPhysicsBody(rectangleOf: tartaro.size)
        tartaro.physicsBody?.affectedByGravity = false
        tartaro.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        tartaro.physicsBody?.categoryBitMask = ColliderType.Tartaro

        self.addChild(tartaro)
        
        //tartaro1
        tartaro1 = SKSpriteNode(imageNamed: "Tartaro")
        tartaro1.name = "Tartaro1"
        tartaro1.anchorPoint = CGPoint(x:0.5, y:0.5)
        tartaro1.position = CGPoint(x:150, y:100)
        tartaro1.zPosition = 1

        //colis1ão
        tartaro1.physicsBody = SKPhysicsBody(rectangleOf: tartaro1.size)
        tartaro1.physicsBody?.affectedByGravity = false
        tartaro1.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        tartaro1.physicsBody?.categoryBitMask = ColliderType.Tartaro

        self.addChild(tartaro1)
        
        

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
            // tartaro.alpha para diminuir a opacidade, 0.0 = transparente
            print("contato feito")
            //pra cada contato, diminuir 0.25 da opacidade
            
            
            tartaro.alpha -= 0.25
            if tartaro.alpha == 0.0{ //só funciona quando diminuir 0.25, e nao 0.10, 0.20
                tartaro.removeFromParent()
            }

        }
        
        if firstBody.node?.name == "Escova" && secondBody.node?.name == "Tartaro1"{
            // tartaro.alpha para diminuir a opacidade, 0.0 = transparente
            print("contato feito")
            //pra cada contato, diminuir 0.25 da opacidade
            
            tartaro1.alpha -= 0.25
            if tartaro1.alpha == 0.0{ //só funciona quando diminuir 0.25, e nao 0.10, 0.20
                tartaro1.removeFromParent()
            }

        }
       
        //existe como fazer um if enemy for removido, passa para a próxima tela?
    }
}
