//
//  PartialViewController.swift
//  The Gas Laws
//
//  Created by Necanow on 6/15/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit
import SceneKit
import GameplayKit

class PartialViewController: UIViewController {
    
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blackLabel: UILabel!
    @IBOutlet weak var pinkLabel: UILabel!
    var allLabels = [UILabel]()
    var measurements = [Double](), bookends = [[Float]]()
    
    @IBOutlet weak var totalLabel: UILabel!
    var total = 6.00, totalMedian = 6.00
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var maxATM: UILabel!
    @IBOutlet weak var minATM: UILabel!
    
    var currentGame: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minATM.minimumScaleFactor = 0.1
        minATM.adjustsFontSizeToFitWidth = true
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = UIColor(red: 255/255.0, green: 206/255.0, blue: 226/255.0, alpha: 1)
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as! GameScene
                currentGame.title.text = "Dalton's Law"
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
        allLabels.append(blueLabel)
        allLabels.append(greenLabel)
        allLabels.append(blackLabel)
        allLabels.append(pinkLabel)
        
        measurements = [6.00, 10.50, 4.50, 1.50]
        bookends = [[4.00, 8.00], [7.00, 14.00], [3.00, 6.00], [1.00, 2.00]]
        
        currentGame.daltonsLawBegin()
    }
    
    @IBAction func tappedSwitch(_ sender: UISwitch) {
        let index = sender.tag
        
        switch index {
        case 0: currentGame.didTapBlue(sender.isOn)
        case 1: currentGame.didTapGreen(sender.isOn)
        case 2: currentGame.didTapBlack(sender.isOn)
        case 3: currentGame.didTapPink(sender.isOn)
        default: break // do nothing
        }
        
        let value = convert(val: sliderOutlet.value, min: bookends[index][0], max: bookends[index][1])
        if sender.isOn {
            total += Double(value)
            totalMedian += measurements[index]
            allLabels[index].text = "= \(String(format: "%.2f", value)) atm"
        } else {
            total -= Double(value)
            totalMedian -= measurements[index]
            allLabels[index].text = ""
        }
        
        updateTotal()
        
        // update the slider bookends
        let ends = sliderBookends()
        minATM.text = "\(String(format: "%.2f", ends[0])) atm"
        maxATM.text = "\(String(format: "%.2f", ends[1])) atm"
    }
    
    func sliderBookends() -> [Double] {
        let add = totalMedian/3
        return [totalMedian-add, totalMedian+add]
    }
    
    func updateTotal() {
        let ends = sliderBookends()
        let value = convert(val: sliderOutlet.value, min: Float(ends[0]), max: Float(ends[1]))
        totalLabel.text = "TOTAL: \(String(format: "%.2f", value)) atm"
    }
    
    @IBAction func onTappedSlider(_ sender: UISlider) {
        currentGame.updateUI("P", Int(sender.value))
        currentGame.updateUI("V", 100 - Int(sender.value))
        
        for ctr in 0..<allLabels.count {
            if allLabels[ctr].text != "" {
                let realVal = convert(val: sender.value, min: bookends[ctr][0], max: bookends[ctr][1])
                allLabels[ctr].text = "= \(String(format: "%.2f", realVal)) atm"
            }
        }
        updateTotal()
    }
    
    func convert(val: Float, min: Float, max: Float) -> Float {
        // i.e. convert num within 0-100 to equivalent num
        // within 4-8
        
        let diffFromMid = val - 50.0
        let zScore = diffFromMid/50 * (max-min)/2
        
        return (max+min)/2 + zScore
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
    
//    @IBAction func onTappedBack(_ sender: Any) {
//        performSegue(withIdentifier: "unwindSegue", sender: self)
//    }
}
