//
//  OverviewViewController.swift
//  The Gas Laws
//
//  Created by Necanow on 7/5/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    
    @IBOutlet var lawDescriptions: [UILabel]!
    @IBOutlet var laws: [UILabel]!
    let answers = ["V / n is a constant.",
                   "P * n is a constant.",
                   "V / T is a constant.",
                   "P / T is a constant.",
                   "P / n is a constant.",
                   "T * n is a constant.",
                   "P(total) = P₁ + P₂ + P₃",
                   "PV = nRT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 253/255.0, blue: 154/255.0, alpha: 1)
        
        for i in 0..<laws.count {
            lawDescriptions[i].minimumScaleFactor = 0.1
            lawDescriptions[i].adjustsFontSizeToFitWidth = true
            didTap(atIndex: i)
        }
    }
    
    @IBAction func onTappedScreen(_ sender: UITapGestureRecognizer) {
        let loc = sender.location(in: self.view)
        
        for lawIndex in 0..<laws.count {
            if laws[lawIndex].frame.contains(loc) {
                didTap(atIndex: lawIndex)
            }
        }
    }
    
    func didTap(atIndex: Int) {
        if laws[atIndex].backgroundColor == .lightGray {
            laws[atIndex].text = answers[atIndex]
            laws[atIndex].backgroundColor = .clear
        } else {
            laws[atIndex].text = " Tap To Reveal"
            laws[atIndex].backgroundColor = .lightGray
        }
    }
}
