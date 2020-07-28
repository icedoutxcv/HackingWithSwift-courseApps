//
//  BuildingNode.swift
//  Project29-ExplodingMonkeys
//
//  Created by icedoutxcv on 22/02/2020.
//  Copyright © 2020 icedoutxcv. All rights reserved.
//

import UIKit
import SpriteKit

class BuildingNode: SKSpriteNode {
    var currentImage: UIImage!
    
    func setup() {
        name = "building"
        
        currentImage = drawBuilding(size: size)
        texture = SKTexture(image: currentImage)
        
        configurePhysics()
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionTypes.building.rawValue
        physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
    }
    
    func drawBulding(size: CGSize) {
        
    }
}
