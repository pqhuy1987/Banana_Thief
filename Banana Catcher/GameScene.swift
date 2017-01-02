import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let ground: Ground = Ground()
    let basketMan: BasketMan = BasketMan()
    let monkey: EvilMonkey = EvilMonkey()
    let scoreLabel: ScoreLabel = ScoreLabel()
    let lives: Lives = Lives()
    
    var touching = false
    var touchLoc = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        backgroundColor = bgColor
        adjustGravity()
        addBackgroundImage()
        addScore()
        addLives()
        addEdgeBody()
        addGround()
        addBasketMan()
        addEvilMonkey()
    }
    
    override func update(_ currentTime: TimeInterval) {
        monkey.move(frame.width)
        if monkey.canThrowBanana() { throwBanana() }
        
        if (touching) { basketMan.move(touchLoc) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = true
        touchLoc = touches.first!.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchLoc = touches.first!.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
    }
    
    
    /* Collision detection */
    
    func didBegin(_ contact: SKPhysicsContact) {
        var b1: SKPhysicsBody
        var b2: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            b1 = contact.bodyA
            b2 = contact.bodyB
        } else {
            b1 = contact.bodyB
            b2 = contact.bodyA
        }
        
        if b1.node?.parent == nil || b2.node?.parent == nil { return }
        
        if b1.categoryBitMask & CollisionCategories.Banana != 0  {
            let banana = b1.node as! Banana
            
            if b2.categoryBitMask & CollisionCategories.BasketMan != 0 {
                banana.removeFromParent()
                basketMan.collect()
                incrementScore()
            }
            else if b2.categoryBitMask & CollisionCategories.Ground != 0 {
                splat(banana)
                decrementLives()
            }
            else {
                print("Unexpected contant test: (\(b1), \(b2))")
            }
        }
    }
    
    
    /* Add game elements */
    
    fileprivate func adjustGravity() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsWorld.contactDelegate = self
    }
    
    fileprivate func addBackgroundImage() {
        let img = SKSpriteNode(imageNamed: "ground.png")
        img.position = CGPoint(x: frame.midX, y: img.size.height / 2)
        img.zPosition = -999
        addChild(img)
    }
    
    fileprivate func addScore() {
        scoreLabel.position = CGPoint(x: 10, y: frame.height - 30)
        addChild(scoreLabel)
    }
    
    fileprivate func addLives() {
        lives.position = CGPoint(x: frame.width - lives.size.width, y: frame.height - 30)
        addChild(lives)
    }
    
    fileprivate func addEdgeBody() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
    }
    
    fileprivate func addGround() {
        ground.position = CGPoint(x: frame.midX, y: ground.size.height / 2)
        addChild(ground)
    }
    
    fileprivate func addBasketMan() {
        basketMan.position = CGPoint(x: frame.midX, y: ground.size.height + 10)
        addChild(basketMan)
    }
    
    fileprivate func addEvilMonkey() {
        monkey.position = CGPoint(x: frame.midX, y: frame.height - 130)
        addChild(monkey)
    }
    
    
    /* Game element actions */
    
    fileprivate func throwBanana() {
        let banana: Banana = Banana()
        banana.position = CGPoint(x: monkey.position.x, y: monkey.position.y)
        addChild(banana)
        
        let throwRange = CGFloat(arc4random_uniform(13)) - 6.0
        
        banana.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        banana.physicsBody?.applyImpulse(CGVector(dx: throwRange, dy: 8))
    }
    
    fileprivate func splat(_ banana: Banana) {
        let splatBanana = SplatBanana()
        
        splatBanana.position = CGPoint(x: banana.position.x, y: ground.size.height + 5)
        
        addChild(splatBanana)
        banana.removeFromParent()
    }
    
    fileprivate func incrementScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        if score % 2 == 0 {
            monkey.enrage()
        }
    }
    
    fileprivate func decrementLives() {
        if lives.isEmpty() {
            monkey.win()
            
            let wait = SKAction.wait(forDuration: 0.3)
            let endGame = SKAction.run { self.gameOver() }
            
            self.run(SKAction.sequence([wait, endGame]))
        }
        else {
            lives.ouch()
        }
    }
    
    fileprivate func gameOver() {        
        let scene = GameOverScene(size: size)
        scene.scaleMode = scaleMode
        
        let transitionType = SKTransition.flipVertical(withDuration: 0.5)
        view?.presentScene(scene,transition: transitionType)
    }
}
