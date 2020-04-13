//
//  falaDino.swift
//  testeSom
//
//  Created by Beatriz Sato on 09/04/20.
//  Copyright © 2020 Beatriz Sato. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class falaDino: SKScene {
    
    var dinoFrames:[SKTexture]?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        var frames:[SKTexture] = []
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let dinoAtlas = SKTextureAtlas(named: "dino")
        
        for index in 1...3{
            let textureName = "dino_\(index)"
            let texture = dinoAtlas.textureNamed(textureName)
            frames.append(texture)
            
        }
        self.dinoFrames = frames
    }
    
    
    func falaDino(){
        let texture = self.dinoFrames![0]
        let dino = SKSpriteNode(texture: texture)
        dino.size = CGSize(width: 140, height: 140)
        
        dino.position = CGPoint(x: 0 ,y: 0)
        self.addChild(dino)
        //dino.run(SKAction.repeatForever(SKAction.animate(with: self.dinoFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        dino.run(SKAction.repeat(SKAction.animate(with: self.dinoFrames!, timePerFrame: 0.07, resize: false, restore: false), count: 7))

    }
    
    
}
