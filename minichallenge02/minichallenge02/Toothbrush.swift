//
//  Escova.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 17/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit

class Toothbrush: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "escova-lado")
        
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "Toothbrush"
        
        //é melhor inicializar a escova com isso ou chamar a função lá no cenário?
        addToothbrushPhysics(sprite: self)
        addToothbrushPosition(sprite: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //eu devia inicializar com isso ou é ok chamar a função lá na EscovaDente?
    func addToothbrushPhysics(sprite: SKSpriteNode){
        //parte física
        let physicsBodySize:CGSize = CGSize(width: 220, height: sprite.size.height/2)
        sprite.physicsBody = SKPhysicsBody(rectangleOf: physicsBodySize, center: CGPoint(x: -330, y: 50))
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = true //permite que a escova interaja com o tartaro
        sprite.physicsBody?.allowsRotation = false //nao deixa ficar girando enquanto mexe

        
        //colisão
        sprite.physicsBody?.categoryBitMask = ColliderType.Toothbrush
        sprite.physicsBody?.collisionBitMask = ColliderType.Tartarus
        sprite.physicsBody?.contactTestBitMask = ColliderType.Tartarus
    }

    func addToothbrushPosition(sprite: SKSpriteNode){
        //para diminuir o tamanho da escova
        sprite.xScale = 0.3
        sprite.yScale = 0.3
    }

}



