import UIKit
import SpriteKit

class Label: SKLabelNode {
    
    init(name: String, size: CGFloat = 30, x: CGFloat, y: CGFloat) {
        super.init()
        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        color = SKColor.white
        fontName = gameFont
        text = name
        fontSize = size
        position = CGPoint(x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
