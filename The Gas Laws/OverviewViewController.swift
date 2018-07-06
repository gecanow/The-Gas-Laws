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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for law in lawDescriptions {
            law.minimumScaleFactor = 0.1
            law.adjustsFontSizeToFitWidth = true
        }
    }
}
