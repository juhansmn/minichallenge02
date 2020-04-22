//
//  Tartaro.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 17/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Tartarus: SKSpriteNode {
    static var tartarusCount = 0
    let id:Int //para verificar qual tártaro está sendo tocado dentro do array e modificar ele
    
    init(id: Int){
        let texture = SKTexture(imageNamed: "tartaro")
        self.id = id
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "Tartarus"
        
        addTartarusPhysics(sprite: self)
        addTartarusPosition(sprite: self)
        Tartarus.tartarusCount += 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTartarusPhysics(sprite: SKSpriteNode){
        //colisão
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        sprite.physicsBody?.categoryBitMask = ColliderType.Tartarus
    }
    
    func addTartarusPosition(sprite: SKSpriteNode){
        sprite.zPosition = 1 //deixa acima do background
        
        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
        let randomPositionX = GKRandomDistribution(lowestValue: -70, highestValue: 70)
        let position = CGFloat(randomPositionX.nextInt())

        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.size = CGSize(width: 45, height: 45)
        sprite.position = CGPoint(x: position, y: -65)
    }

}
