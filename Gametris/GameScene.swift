//
//  GameScene.swift
//  Gametris


import SpriteKit

let BlockSize:CGFloat = 40.0

class GameScene: SKScene {
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x: 0, y: 0)
    
    
    var textureCache = Dictionary<String, SKTexture>()

    func getTexture(imgName: String) -> SKTexture {
        var texture = textureCache[imgName]
        if texture == nil {
            texture = SKTexture(imageNamed: imgName)
            textureCache[imgName] = texture
        }
        return texture!
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.frame.size
        addChild(background)
        addChild(gameLayer)
        
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSizeMake(BlockSize * CGFloat(NumColumns), BlockSize * CGFloat(NumRows)))
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        //myLabel.text = "GameTris!"
        //myLabel.fontSize = 65
        //myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //self.addChild(myLabel)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func addNextMultileToScene(multile: Multile, completion: () -> () = {}) {
        let fadeDur = 0.2
    
        for tile in multile.tiles {
            var texture = getTexture(tile.spriteName)
            
            let sprite = SKSpriteNode(texture: texture, size: CGSizeMake(BlockSize, BlockSize))
            sprite.position = xyToPoint(tile.x, y: tile.y)
            shapeLayer.addChild(sprite)
            tile.sprite = sprite
            
            sprite.alpha = 0
            let fadeAction = SKAction.fadeAlphaTo(0.8, duration: fadeDur)
            fadeAction.timingMode = .EaseIn
            sprite.runAction(fadeAction)
        }
        
        runAction(SKAction.waitForDuration(fadeDur), completion: completion)
    }
    
    func redrawShape(multile: Multile, completion: () -> () = {}) {
        let moveDur = 0.2
        
        for tile in multile.tiles {
            let sprite = tile.sprite!
            
            let moveTo = xyToPoint(tile.x, y: tile.y)
            let moveToAction:SKAction = SKAction.moveTo(moveTo, duration: moveDur)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(moveToAction)
        }
        
        runAction(SKAction.waitForDuration(moveDur), completion: completion)
    }
    
    func xyToPoint(x: Int, y: Int) -> CGPoint {
        return CGPoint(x: CGFloat(x - 4) * BlockSize,
                       y: -CGFloat(y - 7) * BlockSize)
    }
    

}












