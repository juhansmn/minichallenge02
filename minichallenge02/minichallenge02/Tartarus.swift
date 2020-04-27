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
        let texture = SKTexture(imageNamed: "tartarusImage")
        self.id = id
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self.name = "Tartarus"
        
        addTartarusPhysics(sprite: self)
        Tartarus.tartarusCount += 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTartarusPhysics(sprite: SKSpriteNode){
        //colisão
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 4)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = false //outro sprite nao vai poder mexer nele
        sprite.physicsBody?.categoryBitMask = ColliderType.Tartarus
        sprite.physicsBody?.contactTestBitMask = ColliderType.Toothbrush
    }
    
    func addTartarusPosition(sprite: SKSpriteNode){
        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
        let randomPositionX = GKRandomDistribution(lowestValue: -70, highestValue: 70)
        let position = CGFloat(randomPositionX.nextInt())

        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.size = CGSize(width: 45, height: 45)
        sprite.position = CGPoint(x: position, y: -65)
    }
    
    func addTutorialPosition(sprite: SKSpriteNode){
        sprite.zPosition = 2 //deixa acima do background e do dino
        
        //randomizar posição dos tártaros entre -200 e 200 na linha horizontal
        let randomPositionX = GKRandomDistribution(lowestValue: -150, highestValue: -80)
        let position = CGFloat(randomPositionX.nextInt())

        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.size = CGSize(width: 45, height: 45)
        if DeviceType.isiPhone8plus || DeviceType.isiPhone11orProMax{
            sprite.position = CGPoint(x: position, y: -100)
        }else{
            sprite.position = CGPoint(x: position, y: -90)
        }
        
    }

}
