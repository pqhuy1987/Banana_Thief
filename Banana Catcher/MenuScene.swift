import UIKit
import SpriteKit

class MenuScene: SKScene {

    let newGameNode = "newGame"
    
    override func didMove(to view: SKView) {
        backgroundColor = bgColor
        addTitle()
        addStartBtn()
        addFallingBananas()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first!.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if(touchedNode.name == newGameNode){
            let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            
            let transitionType = SKTransition.flipVertical(withDuration: 0.5)
            view?.presentScene(scene,transition: transitionType)
        }
    }
    
    func addTitle() {
        let title = RotatingText(fontNamed: gameFont)
        
        title.setTextFontSizeAndRotate("Banana Catcher", theFontSize: 30)
        title.position = CGPoint(x: size.width/2,y: size.height/2 + 200)
        title.fontColor = UIColor.black
        addChild(title)
    }
    
    func addStartBtn() {
        let startGameButton = SKSpriteNode(imageNamed: "newgamebtn")
        
        startGameButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        startGameButton.name = newGameNode
        addChild(startGameButton)
    }
    
    func addFallingBananas() {
        if let rain = SKEmitterNode(fileNamed: "BananaRain") {
            rain.position = CGPoint(x: size.width/2, y: size.height + 50)
            rain.zPosition = -1000
            addChild(rain)
        }
    }
}
