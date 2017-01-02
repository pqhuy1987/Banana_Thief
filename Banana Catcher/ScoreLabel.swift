import UIKit
import SpriteKit

class ScoreLabel: SKLabelNode {

    init(name: String = "Score", score: Int = 0) {
        super.init()
        text = "\(name): \(score)"
        color = SKColor.white
        fontName = gameFont
        fontSize = 22
        alpha = 0.75
        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScore(_ score: Int) {
        text = "Score: \(score)"
    }
}
