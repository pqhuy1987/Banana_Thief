import UIKit
import SpriteKit

class Banana: SKSpriteNode {
    
    fileprivate var splat: Bool = false

    init() {
        let texture = SKTexture(imageNamed: "banana")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        
        self.physicsBody?.categoryBitMask = CollisionCategories.Banana
        self.physicsBody?.contactTestBitMask = CollisionCategories.BasketMan | CollisionCategories.Ground
        self.physicsBody?.collisionBitMask = CollisionCategories.Ground | CollisionCategories.EdgeBody

        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func animate() {
        let rotDir = [-1.0, 1.0][Int(arc4random_uniform(2))]
        let rotSpeed = 2.0 / Double(arc4random_uniform(5) + 1)
        let rot = SKAction.rotate(byAngle: CGFloat(rotDir * M_PI) * 2.0, duration: rotSpeed)
        
        self.run(SKAction.repeatForever(rot))
    }
}
