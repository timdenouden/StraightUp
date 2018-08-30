//
//  TestScene.swift
//  StraightUp
//
//  Created by Timothy DenOuden on 4/18/17.
//  Copyright © 2017 Timothy DenOuden. All rights reserved.
//

import SpriteKit

class TestScene : SKScene {
    
    var noodle: SKSpriteNode?
    var headHappyTexture: SKTexture?
    var headSadTexture: SKTexture?
    var headNode: SKSpriteNode?
    var leftArmNode: SKSpriteNode?
    var alertNode: SKSpriteNode?
    let numNodes = 8
    var timeStep = 0.0
    var previousTimestep = 0.0
    let data = [0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.1599999668,
        0.167999971,
        0.1719999791,
        0.1719999791,
        0.1719999791,
        0.1799999834,
        0.1799999834,
        0.2399999738,
        0.3239999652,
        0.3999999642,
        0.4719999552,
        0.5599999547,
        0.6079999685,
        0.6319999695,
        0.6559999705,
        0.6759999753,
        0.6759999753,
        0.6599999667,
        0.6559999705,
        0.6479999781,
        0.6399999857,
        0.6359999895,
        0.6199999809,
        0.59599998,
        0.5839999676,
        0.5599999666,
        0.543999958,
        0.5479999542,
        0.5599999666,
        0.5479999781,
        0.5599999666,
        0.571999979,
        0.571999979,
        0.5559999704,
        0.5239999652,
        0.4479999781,
        0.34399997,
        0.2519999862,
        0.1679999948,
        0.1199999929,
        0.09999998805,
        0.1039999843,
        0.09599997995,
        0.08799997565,
        0.08399997945,
        0.09199998375,
        0.09599999185,
        0.1039999962,
        0.1120000005,
        0.1200000048,
        0.1200000048,
        0.1159999967,
        0.1119999886,
        0.1119999886,
        0.1119999886,
        0.1079999805,
        0.1119999886,
        0.1639999867,
        0.2639999867,
        0.3839999914,
        0.5120000005,
        0.623999989,
        0.675999999,
        0.6839999914,
        0.6679999829,
        0.6479999781,
        0.6239999772,
        0.6039999724,
        0.5759999753,
        0.54399997,
        0.5119999648,
        0.4919999719,
        0.4799999714,
        0.4759999752,
        0.4839999795,
        0.4839999795,
        0.4799999833,
        0.4759999871,
        0.4679999828,
        0.4519999861,
        0.4399999856,
        0.4559999823,
        0.4519999742,
        0.4039999723,
        0.3399999738,
        0.2839999795,
        0.2119999767,
        0.1519999862,
        0.1359999896,
        0.1479999901,
        0.1519999863,
        0.1519999863,
        0.1599999787,
        0.1639999749,
        0.1639999749,
        0.167999983,
        0.1719999911,
        0.1719999911,
        0.1759999992,
        0.1799999953,
        0.1839999915,
        0.1839999915,
        0.1839999915,
        0.1839999915,
        0.1799999953,
        0.1759999992,
        0.1759999992,
        0.1759999992,
        0.1759999992]
    
    var dataStep = 1000000
    
    override func didMove(to view: SKView){
        
        let landscapeBack = SKSpriteNode(imageNamed: "background")
        landscapeBack.size = CGSize(width: self.size.width, height: self.size.height)
        landscapeBack.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(landscapeBack)
        
        let header = SKSpriteNode(color: .white, size: CGSize(width: size.width, height: 160))
        header.position = CGPoint(x: size.width / 2, y: 0)
        addChild(header)
        
        let noodleNodeTexture = SKTexture(imageNamed: "bodyNode")
        let SIZE_FACTOR = 40.0
        let noodleNodeSize = CGSize(width: SIZE_FACTOR, height: SIZE_FACTOR * 1.22727)
        
        noodle = SKSpriteNode(texture: noodleNodeTexture, size: noodleNodeSize)
        noodle?.anchorPoint = CGPoint(x: 0.5, y:0.407)
        noodle?.position = CGPoint(x: self.size.width / 2, y: 150)
        
        var nodeTemp: SKSpriteNode?
        var currentParentNode: SKSpriteNode?
        let bodyTopTexture = SKTexture(imageNamed: "bodyNodeTop")
        currentParentNode = noodle
        
        for index in 1..<numNodes {
            if(index == numNodes - 1) {
                nodeTemp = SKSpriteNode(texture: bodyTopTexture, size: noodleNodeSize)
            }
            else {
                nodeTemp = SKSpriteNode(texture: noodleNodeTexture, size: noodleNodeSize)
            }
            nodeTemp?.anchorPoint = CGPoint(x: 0.5, y:0.407)
            nodeTemp?.position = CGPoint(x: 0, y: noodleNodeSize.height - (noodleNodeSize.width))
            currentParentNode!.addChild(nodeTemp!)
            currentParentNode = nodeTemp
        }
        let armTexture = SKTexture(imageNamed: "arm")
        let armRect = CGSize(width: 16, height: 80)
        leftArmNode = SKSpriteNode(texture: armTexture, size: armRect)
        leftArmNode!.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        leftArmNode!.position = CGPoint(x: -8, y: 12)
        currentParentNode!.addChild(leftArmNode!)
        
        //let rightArmNode = SKSpriteNode(texture: armTexture, size: armRect)
        //rightArmNode.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        //rightArmNode.position = CGPoint(x: 20, y: 20)
        //currentParentNode!.addChild(rightArmNode)
        
        let neckTexture = SKTexture(imageNamed: "neck")
        let neckNode = SKSpriteNode(texture: neckTexture, size: CGSize(width: 14, height: 24))
        neckNode.anchorPoint = CGPoint(x: 0.5, y: 0.7)
        neckNode.position = CGPoint(x: -1, y: 40)
        currentParentNode!.addChild(neckNode)
        currentParentNode = neckNode
        
        headHappyTexture = SKTexture(imageNamed: "head")
        headSadTexture = SKTexture(imageNamed: "headSad")
        headNode = SKSpriteNode(texture: headHappyTexture, size: CGSize(width: 42, height: 42 * 1.2))
        headNode!.anchorPoint = CGPoint(x: 0.45, y: 0.15)
        currentParentNode?.addChild(headNode!)
        
        
        //let background = SKSpriteNode(imageNamed: "plad")
        //background.position = CGPoint(x: size.width / 2, y: size.height / 2 - 60)
        //let cropNode = SKCropNode()
        //cropNode.maskNode = noodle!
        //cropNode.addChild(background)
        
        let pants = SKSpriteNode(imageNamed: "pants")
        pants.size = CGSize(width: 46, height: 102)
        pants.position = CGPoint(x: -1, y: -10)
        pants.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        noodle?.addChild(pants)
        
        addChild(noodle!)
        
        alertNode = SKSpriteNode(imageNamed: "alert")
        alertNode!.size = CGSize(width: 10, height: 40)
        alertNode!.position = CGPoint(x: (self.size.width / 2) - 40, y: (self.size.height / 2) + 40)
        alertNode!.isHidden = true
        addChild(alertNode!)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - previousTimestep
        timeStep = timeStep + delta
        if(dataStep < data.count && timeStep > 0.1) {
            slouch(by: CGFloat(data[dataStep]) + 0.1)
            dataStep += 1
            timeStep = 0.0
        }
        previousTimestep = currentTime
    }
    
    public func reset() {
        dataStep = 0
        timeStep = 0.0
    }
    
    public func slouch(by ratio: CGFloat) {
        var currentParentNode: SKNode?
        currentParentNode = noodle
        for index in 1...numNodes {
            currentParentNode?.zRotation = -(ratio * ratio * ratio) * 0.02 * CGFloat(index)
            if let child = currentParentNode?.children.first {
                currentParentNode = child as! SKSpriteNode
            }
        }
        leftArmNode!.zRotation = -(ratio * 0.1)
        leftArmNode!.position.x = -(12 * (1 - ratio)) + 6
        if(ratio > 0.9) {
            headNode?.texture = headSadTexture
            alertNode!.isHidden = false
        }
        else {
            headNode?.texture = headHappyTexture
            alertNode!.isHidden = true
        }
    }
}
