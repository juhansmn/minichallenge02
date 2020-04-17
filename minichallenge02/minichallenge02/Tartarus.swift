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
    static var cont = 0
    
    init(){
        let texture = SKTexture(imageNamed: "tartaro")
        
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "Tartarus"
        
        addTartarusPhysics(sprite: self)
        addTartarusPosition(sprite: self)
        Tartarus.cont += 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTartarusPhysics(sprite: SKSpriteNode){
        //colisão
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        sprite.physicsBody?.categoryBitMask = ColliderType.Tartaro
    }
    
    func addTartarusPosition(sprite: SKSpriteNode){
        sprite.zPosition = 1 //deixa acima do background
        
        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
        let randomPosition = GKRandomDistribution(lowestValue: -70, highestValue: 70)
        let position = CGFloat(randomPosition.nextInt())
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.size = CGSize(width: 50, height: 50)
        sprite.position = CGPoint(x: position, y: -60)
    }
}
