import UIKit
import SpriteKit

class RotatingText: SKLabelNode {
    
    func setTextFontSizeAndRotate(_ theText: String, theFontSize: CGFloat){
        self.text = theText;
        self.fontSize = theFontSize
        
        let rotSequence = SKAction.sequence([
            SKAction.rotate(byAngle: 0.1, duration: 3),
            SKAction.rotate(byAngle: -0.2, duration: 6),
            SKAction.rotate(byAngle: 0.1, duration: 3)])
        
        self.run(SKAction.repeatForever(rotSequence))
    }
}
