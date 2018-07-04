//
//  ParticleHandler.swift
//  The Gas Laws
//
//  Created by Necanow on 6/18/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class ParticleHandler: NSObject {
    
    var particleArray = [SKShapeNode]()
    var particlePos : CGPoint!
    
    var speed : Double!
    var radius : Int!
    var color : UIColor!
    
    convenience init(speed: Double, rad: Int, color: UIColor, position: CGPoint) {
        self.init()
        self.speed = speed
        self.radius = rad
        self.color = color
        self.particlePos = position
    }
    
    convenience init(position: CGPoint) {
        self.init()
        speed = 80.0
        radius = 7
        color = .blue
        particlePos = position
    }
    
    
    //====================================
    // Emits a (num) of particles with
    // (radius) and (speed)
    //====================================
    func emit(_ num: Int, toGame: GameScene) {
        for _ in 0..<num {
            let particle = SKShapeNode(circleOfRadius: CGFloat(radius))
            particle.position = particlePos
            particle.fillColor = color
            particle.name = "particle"
            
            particle.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
            particle.physicsBody?.friction = 0
            particle.physicsBody?.restitution = 1.0
            particle.physicsBody?.linearDamping = 0
            particle.physicsBody?.allowsRotation = false
            
            particle.physicsBody?.categoryBitMask = 4
            particle.physicsBody?.contactTestBitMask = 0
            particle.physicsBody?.collisionBitMask = 0
            
            particle.physicsBody?.velocity = CGVector(dx: speed*cos(randomAngle()), dy: speed*sin(randomAngle()))
            
            particleArray.append(particle)
            toGame.addChild(particle)
        }
    }
    
    //====================================
    // Helper Function:
    // Returns a random angle in radians
    //====================================
    func randomAngle() -> Double {
        return Double(arc4random_uniform(360)) * .pi / 180.0
    }
    
    //====================================
    // Removes a (num) of particles
    //====================================
    func remove(_ num: Int) {
        for _ in 0..<num {
            let particle = particleArray.popLast()
            particle?.removeAllActions()
            particle?.removeFromParent()
        }
    }
    
    //====================================
    // Adjusts the speed of all current
    // and future particles
    //====================================
    func setSpeed(to: Double, from: Double) {
        for p in particleArray {
            p.physicsBody?.velocity.dx = (p.physicsBody?.velocity.dx)! * CGFloat(1+(to-from)/10.0)
            p.physicsBody?.velocity.dy = (p.physicsBody?.velocity.dy)! * CGFloat(1+(to-from)/10.0)
        }
    }
}
