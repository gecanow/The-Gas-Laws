//
//  GeneralViewController.swift
//  The Gas Laws
//
//  Created by Necanow on 7/5/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit
import SceneKit
import GameKit

class GeneralViewController: UIViewController {
    
    var currentGame: GameScene!
    var measurement = "T"
    
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //scene.backgroundColor = .red
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as! GameScene
                currentGame.title.text = "General Overview"
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func onTappedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            measurement = "T"
            lowLabel.text = "1 K"
            highLabel.text = "100 K"
        case 1:
            measurement = "P"
            lowLabel.text = "1 atm"
            highLabel.text = "5 atm"
        case 2:
            measurement = "V"
            lowLabel.text = "10 mL"
            highLabel.text = "50 mL"
        default:
            measurement = "n"
            lowLabel.text = "1 mol"
            highLabel.text = "100 mol"
        }
    }
    
    @IBAction func onTappedSlider(_ sender: UISlider) {
        currentGame.updateUI(measurement, Int(sender.value))
    }
}
