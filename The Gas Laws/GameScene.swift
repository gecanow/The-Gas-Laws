//
//  GameScene.swift
//  The Gas Laws
//
//  Created by Necanow on 6/14/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Fields -- Laws //
    private var particleLoc : SKNode!
    private var lid : SKNode!
    private var pHandle : SKShapeNode!
    
    weak var viewController: GameViewController!
    
    var allBlue : ParticleHandler!
    
    var slider1Type = "V"
    var slider2Type = "n"
    
    var originalLidY : CGFloat!
    var lastSpeed = 10.0
    
    // Fields -- Dalton //
    var allGreen : ParticleHandler!
    var allBlack : ParticleHandler!
    var allPink : ParticleHandler!
    
    //==============================
    // DID MOVE
    //==============================
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        particleLoc = self.childNode(withName: "//particleLocation")
        lid = self.childNode(withName: "//lid")
        originalLidY = lid.position.y
        
        pHandle = SKShapeNode(circleOfRadius: 30)
        pHandle.fillColor = .red
        self.addChild(pHandle)
        pHandle.position = CGPoint(x: lid.position.x, y: lid.position.y+20)
        
        allBlue = ParticleHandler(speed: 80.0, rad: 7, color: .blue, position: particleLoc.position)
        allBlue.emit(50, toGame: self)
        
        allGreen = ParticleHandler(speed: 80.0, rad: 12, color: .green, position: particleLoc.position)
        allBlack = ParticleHandler(speed: 80.0, rad: 4, color: .black, position: particleLoc.position)
        allPink = ParticleHandler(speed: 80.0, rad: 7, color: .magenta, position: particleLoc.position)
    }
    
    //====================================
    // TOUCH FUNCTIONS
    //====================================
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //====================================
    // Handles contact
    //====================================
    func didBegin(_ contact: SKPhysicsContact) {
        var part = contact.bodyA.node
        var wall = contact.bodyB.node
        
        if contact.bodyB.node?.name == "particle" {
            part = contact.bodyB.node
            wall = contact.bodyA.node
        }
        
        if wall?.name == "left" || wall?.name == "right" {
            part?.physicsBody?.velocity.dx = -(part?.physicsBody?.velocity.dx)!
        } else {
            part?.physicsBody?.velocity.dy = -(part?.physicsBody?.velocity.dy)!
        }
    }
    
    //====================================
    // Updates the UI from the slider
    //====================================
    func updateUI(_ with: String, _ value: Int) {
        switch with {
        case "V":
            lid.position.y = originalLidY+CGFloat(value - 50)
            pHandle.position.y = originalLidY+CGFloat(value - 30)
            volumeChecker()
        case "n":
            let count = allBlue.particleArray.count
            if (value+1) > count {
                allBlue.emit((value+1)-count, toGame: self)
            } else {
                allBlue.remove(count-(value+1))
            }
        case "P":
            pHandle.run(SKAction.scale(to: CGFloat(Double(value)/50.0), duration: 0.1))
        default: // "T"
            let realVal = Double(value/4)
            if realVal != lastSpeed {
                allBlue.setSpeed(to: realVal, from: lastSpeed)
                lastSpeed = realVal
            }
        }
    }
    
    //==========================================
    // Helper function that ensures particles
    // don't leave the container when the
    // volume is adjusted
    //===========================================
    func volumeChecker() {
        for arr in [allBlue, allGreen, allBlack, allPink] {
            for p in (arr?.particleArray)! {
                if p.position.y > lid.position.y {
                    p.removeAllActions()
                    p.removeFromParent()
                    arr?.particleArray.remove(at: (arr?.particleArray.index(of: p)!)!)
                
                    arr?.emit(1, toGame: self)
                }
            }
        }
    }
    
    //--------------------------------
    // DALTON'S LAW FUNCTIONS
    //--------------------------------
    
    func daltonsLawBegin() {
        //emit(50)
    }
    
    func didTapBlue(_ on: Bool) {
        if on {
            allBlue.emit(50, toGame: self)
        } else {
            allBlue.remove(50)
        }
    }
    
    func didTapGreen(_ on: Bool) {
        if on {
            allGreen.emit(50, toGame: self)
        } else {
            allGreen.remove(50)
        }
    }
    
    func didTapBlack(_ on: Bool) {
        if on {
            allBlack.emit(50, toGame: self)
        } else {
            allBlack.remove(50)
        }
    }
    
    func didTapPink(_ on: Bool) {
        if on {
            allPink.emit(50, toGame: self)
        } else {
            allPink.remove(50)
        }
    }
}
