import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var hWidth: CGFloat = 0.0
    var hHeight: CGFloat = 0.0
    
    var highScore: Int = 0
    
    let retryBtnNode = "retryBtn"
    
    override func didMove(to view: SKView) {
        backgroundColor = bgColor
        hWidth = size.width / 2
        hHeight = size.height / 2
        
        updateHighScore()
        
        addTitle()
        addScoreBoard()
        addReplayBtn()
        addFallingBananas()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first!.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if(touchedNode.name == retryBtnNode){
            let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipVertical(withDuration: 0.5)
            view?.presentScene(scene,transition: transitionType)
        }
    }
    
    fileprivate func updateHighScore() {
        let defaults: UserDefaults = UserDefaults.standard
    
        highScore = (defaults.value(forKey: "highScore") as AnyObject).intValue ?? 0
        print(highScore)
        defaults.synchronize()
    
        if score > highScore {
            highScore = score
            defaults.set(highScore, forKey: "highScore")
            defaults.synchronize()
        }
    }
    
    fileprivate func addTitle() {
        let title = RotatingText(fontNamed: gameFont)
        
        title.setTextFontSizeAndRotate("Game over!", theFontSize: 30)
        title.position = CGPoint(x: hWidth, y: hHeight + 200)
        title.fontColor = UIColor.black
        addChild(title)
    }
    
    fileprivate func addScoreBoard() {
        let scoreBoard = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 300, height: 160), cornerRadius: 4.0)
        scoreBoard.fillColor = SKColor.black
        scoreBoard.alpha = 0.75
        scoreBoard.position = CGPoint(x: hWidth - 150, y: hHeight - 50)
        addChild(scoreBoard)
        
        let bHeight = scoreBoard.frame.height
        scoreBoard.addChild(Label(name: "Score:", size: 30, x: hWidth, y: bHeight - 40))
        scoreBoard.addChild(Label(name: score.description, size: 25, x: hWidth, y: bHeight - 70))
        scoreBoard.addChild(Label(name: "High Score:", size: 30, x: hWidth, y: bHeight - 120))
        scoreBoard.addChild(Label(name: highScore.description, size: 25, x: hWidth, y: bHeight - 150))
    }
    
    fileprivate func addReplayBtn() {
        let btn = Label(name: "Retry?", size: 20, x: hWidth, y: hHeight - 100)
        btn.name = retryBtnNode
        addChild(btn)
    }
    
    fileprivate func addFallingBananas() {
        if let rain = SKEmitterNode(fileNamed: "BananaRain") {
            rain.position = CGPoint(x: size.width/2, y: size.height + 50)
            rain.zPosition = -1000
            addChild(rain)
        }
    }
}
