//
//  GameViewController.swift
//  The Gas Laws
//
//  Created by Necanow on 6/14/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // Fields //
    
    var currentGame: GameScene!
    @IBOutlet weak var keptConstant: UILabel!
    @IBOutlet weak var relationDescription: UILabel!
    @IBOutlet weak var relation: UILabel!
    
    @IBOutlet weak var max1: UILabel!
    @IBOutlet weak var min1: UILabel!
    @IBOutlet weak var max2: UILabel!
    @IBOutlet weak var min2: UILabel!
    
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    
    var sTypes : [String]!
    
    //========================================
    // VIEW DID LOAD
    //========================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as! GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        setLabels()
        realign(slider1, sTypes[0])
        realign(slider2, sTypes[1])
    }
    
    //========================================
    // Updates the GameScene when the user
    // slides either of the UISliders
    //========================================
    @IBAction func didSlide(_ sender: UISlider) {
        currentGame.updateUI(sTypes[sender.tag], Int(sender.value))
        
        // here we also automatically slide the other slider!
        // let's get the appropriate slide for a direct or indirect relationship
        var distanceFromMid = sender.value - 50
        if sTypes[2] == "*" { distanceFromMid *= -1 }
        
        if sender.tag == 0 {
            // slide slider2
            slider2.value = 50 + distanceFromMid
            currentGame.updateUI(sTypes[1], Int(slider2.value))
        } else {
            // slider slider1
            slider1.value = 50 + distanceFromMid
            currentGame.updateUI(sTypes[0], Int(slider1.value))
        }
    }
    
    //========================================
    // Realigns the slider's max and min
    // depending on the type
    //========================================
    func realign(_ slider: UISlider, _ type: String) {
        switch type {
        case "V":
            slider.minimumValue = 0
            slider.maximumValue = 100
            slider.value = 50
        case "P":
            slider.minimumValue = 0 //5
            slider.maximumValue = 100 //15
            slider.value = 50 //10
        case "T":
            slider.minimumValue = 0
            slider.maximumValue = 100
            slider.value = 50
        default:
            slider.minimumValue = 0
            slider.maximumValue = 100
            slider.value = 50
        }
    }
    
    //========================================
    // Sets all the labels correctly
    //========================================
    func setLabels() {
        let labels1 = getLabelsFor(sTypes[0])
        max1.text = labels1[0]
        min1.text = labels1[1]
        
        let labels2 = getLabelsFor(sTypes[1])
        max2.text = labels2[0]
        min2.text = labels2[1]
        
        var allTypes = ["Pressure", "Temperature", "Moles", "Volume"]
        allTypes.remove(at: allTypes.index(of: fullName(sTypes[0]))!)
        allTypes.remove(at: allTypes.index(of: fullName(sTypes[1]))!)
        keptConstant.text = "\(allTypes[0]) and \(allTypes[1])"
        
        relationDescription.text = "View \(fullName(sTypes[2])) Relationship:"
        relation.text = "\(sTypes[0]) \(sTypes[2]) \(sTypes[1])"
    }
    
    //========================================
    // Helper function that returns a String
    // array [maxLabel, minLabel]
    //========================================
    func getLabelsFor(_ type: String) -> [String] {
        switch type {
        case "V":
            return ["50 mL", "10 mL"]
        case "P":
            return ["5 atm", "1 atm"]
        case "T":
            return ["100 K", "1 K"]
        case "n":
            return ["100 mol", "1 mol"]
        default:
            return ["", ""]
        }
    }
    
    //========================================
    // Helper function that returns the full
    // name for the abbreviation, forAbb
    //========================================
    func fullName(_ forAbb: String) -> String {
        switch forAbb {
        case "V": return "Volume"
        case "P": return "Pressure"
        case "T": return "Temperature"
        case "n": return "Moles"
        case "*": return "INDIRECT"
        case "/": return "DIRECT"
        default: return ""
        }
    }
    
    
    
    
    
    
    
    
    
    //=====================//
    // AUTOMATED FUNCTIONS //
    //=====================//
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func onTappedBack(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
}
