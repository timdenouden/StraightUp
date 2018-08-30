//
//  PostureScene.swift
//  StraightUp
//
//  Created by Timothy DenOuden on 4/3/17.
//  Copyright © 2017 Timothy DenOuden. All rights reserved.
//

import SpriteKit

class PostureScene : SKScene {
    
    //private let pelvis = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 30, height: 60))
    private let pelvis = SKSpriteNode(imageNamed: "pelvis")
    private let lowerStomach = SKSpriteNode(imageNamed: "lowerStomach")
    private let upperStomach = SKSpriteNode(imageNamed: "upperStomach")
    private let chest = SKSpriteNode(imageNamed: "chest")
    private let neck = SKSpriteNode(imageNamed: "neck")
    private let head = SKSpriteNode(imageNamed: "head")
    
    private var lineShape: SKShapeNode?
    private let noodleSprite = SKSpriteNode(color: .black, size: CGSize(width: 20, height: 100))
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.backgroundColor = UIColor.clear
        pelvis.anchorPoint = CGPoint(x: 0.5, y:0.0)
        pelvis.position = CGPoint(x: size.width / 2, y: size.height / 8)
        pelvis.zPosition = 1
        
        lowerStomach.anchorPoint = CGPoint(x: 0.5, y:0.4)
        lowerStomach.position = CGPoint(x: 2, y: pelvis.size.height)
        lowerStomach.zPosition = -1
        pelvis.addChild(lowerStomach)
        
        upperStomach.anchorPoint = CGPoint(x: 0.6, y:0.1)
        upperStomach.position = CGPoint(x: 0, y: lowerStomach.size.height - 7)
        upperStomach.zPosition = -1
        lowerStomach.addChild(upperStomach)
        
        chest.anchorPoint = CGPoint(x: 0.5, y:0.0)
        chest.position = CGPoint(x: -5, y: upperStomach.size.height - 7)
        chest.zPosition = -1
        upperStomach.addChild(chest)
        
        neck.anchorPoint = CGPoint(x: 0.5, y:0.2)
        neck.position = CGPoint(x: -1, y: chest.size.height - 2)
        neck.zPosition = -1
        chest.addChild(neck)
        
        head.anchorPoint = CGPoint(x: 0.4, y:0.2)
        head.position = CGPoint(x: 1, y: neck.size.height - 2)
        head.zPosition = -1
        neck.addChild(head)
        
        //addChild(pelvis)
        slouch(by: 0.5)
        
        let background = SKSpriteNode(imageNamed: "plad")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        let cropNode = SKCropNode()
        cropNode.maskNode = pelvis
        cropNode.addChild(background)
        addChild(cropNode)
    }
    
    public func slouch(by ratio: CGFloat) {
        pelvis.zRotation = -(ratio * 0.1)
        lowerStomach.zRotation = -(ratio * 0.2)
        upperStomach.zRotation = -(ratio * 0.3)
        chest.zRotation = -(ratio * 0.4)
        neck.zRotation = (ratio * 0.2)
        head.zRotation = (ratio * 0.4)
    }
}
