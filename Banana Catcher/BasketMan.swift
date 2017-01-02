import UIKit
import SpriteKit

class BasketMan: SKSpriteNode {

    fileprivate let velocity: CGFloat = 6.0
    fileprivate var blink_textures = [SKTexture]()
    fileprivate var catch_textures = [SKTexture]()
    
    init() {
        let texture = SKTexture(imageNamed: "idle.png")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!,size:self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = CollisionCategories.BasketMan
        self.physicsBody?.contactTestBitMask = CollisionCategories.Banana
        self.physicsBody?.collisionBitMask = CollisionCategories.Ground | CollisionCategories.EdgeBody
        
        loadTextures()
        animate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(_ touch: CGPoint) {
        let dx = touch.x - position.x
        let mag = abs(dx)
        
        if(mag > 3.0) {
            position.x += dx / mag * velocity
        }
    }
    
    func collect() {
        let catchAnim = SKAction.animate(with: catch_textures, timePerFrame: 0.05)
        
        self.run(catchAnim)
    }
    
    fileprivate func animate() {
        let blinkAnim = SKAction.animate(with: blink_textures, timePerFrame: 0.05)
        let delay = SKAction.wait(forDuration: 1.0)
        
        self.run(SKAction.repeatForever(SKAction.sequence([blinkAnim, delay])))
    }
    
    fileprivate func loadTextures() {
        for i in 1...4 {
            blink_textures.append(SKTexture(imageNamed: "blink_\(i).png"))
        }
        for i in 1...8 {
            catch_textures.append(SKTexture(imageNamed: "catch_\(i).png"))
        }
    }
}
