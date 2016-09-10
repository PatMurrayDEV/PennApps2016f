//
//  PHProblemsViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 10/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PHProblemsViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var button1: HPButton!
    @IBOutlet weak var button2: HPButton!
    @IBOutlet weak var button3: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func button1Tapped(_ sender: AnyObject) {

        
    }
    
    @IBAction func button2Tapped(_ sender: AnyObject) {
//        PHUtilities.callNumber(phoneNumber: "19732948935")
    }
    
    @IBAction func button3Tapped(_ sender: AnyObject) {
    }

}
