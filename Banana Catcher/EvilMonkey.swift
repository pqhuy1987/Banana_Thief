import UIKit
import SpriteKit

class EvilMonkey: SKSpriteNode {
    
    fileprivate let step: CGFloat = 1.0
    fileprivate var direction: CGFloat = -1.0
    fileprivate var cooldown: Double = 2.0
    fileprivate var canThrow: Bool = true
    fileprivate var victorious: Bool = false

    init() {
        let texture = SKTexture(imageNamed: "evil-monkey")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!,size:self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = false

        self.physicsBody?.categoryBitMask = CollisionCategories.EvilMonkey
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
        
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(_ range: CGFloat) {
        if (position.x > range - size.width) || (position.x < size.width) {
                direction = -direction
        }
        position.x += direction * step
    }
    
    func enrage() {
        if cooldown > 0.5 {
            cooldown -= 0.2
        } else {
            cooldown = 1.0
        }
    }
    
    func win() {
        victorious = true
    }
    
    func canThrowBanana() -> Bool {
        if victorious { return false }
        
        let couldThrow = canThrow
        if canThrow {
            canThrow = false
            Timer.scheduledTimer(timeInterval: cooldown, target: self, selector: #selector(EvilMonkey.updateCanThrow), userInfo: nil, repeats: false)
        }
        return couldThrow
    }
    
    internal func updateCanThrow() {
        canThrow = true
    }
    
    fileprivate func animate() {
    }
}
