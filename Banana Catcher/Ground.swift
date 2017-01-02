import UIKit
import SpriteKit

class Ground: SKSpriteNode {

    init() {
        let groundSize = CGSize(width: 400, height: 145)
        super.init(texture: nil, color: SKColor.clear, size: groundSize)

        self.physicsBody = SKPhysicsBody(rectangleOf: groundSize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = CollisionCategories.Ground
        self.physicsBody?.contactTestBitMask = CollisionCategories.Banana
        self.physicsBody?.collisionBitMask = CollisionCategories.BasketMan | CollisionCategories.Banana
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
