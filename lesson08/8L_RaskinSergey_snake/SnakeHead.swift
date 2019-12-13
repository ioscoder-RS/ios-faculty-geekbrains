//
//  SnakeHead.swift
//  8L_RaskinSergey_snake
//
//  Created by raskin-sa on 11/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategory.SnakeHead
        
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple | CollisionCategory.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
}
