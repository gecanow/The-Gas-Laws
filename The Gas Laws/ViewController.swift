//
//  ViewController.swift
//  The Gas Laws
//
//  Created by Necanow on 6/14/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Slider possibilities (arranged based on slider tags)
    let sliders = [["V", "n", "/"], ["P", "V", "*"], ["V", "T", "/"], ["P", "T", "/"], ["P", "n", "/"], ["T", "n", "*"]]
    
    //========================================
    // VIEW DID LOAD
    //========================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //========================================
    // Segue!!!
    //========================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = (sender as! UIButton).tag
        if index <= 5 {
            let dvc = segue.destination as! GameViewController
        
            dvc.sTypes = sliders[index]
        }
    }
    
    //========================================
    // Unwind segue!!!
    //========================================
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
}
