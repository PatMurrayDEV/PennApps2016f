//
//  PHCheckOutViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 11/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PHCheckOutViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
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
        //        let timeStamp = NSDate().dateStringWithFormat(format: "Hmm a")
        //     PHUtilities.smsNumber(phoneNumber: "19732948935", message: "Harrison checked out of your property at \(timeStamp)")
        
        
        
        self.performSegue(withIdentifier: "finishSegue", sender: self)
    }
    
    @IBAction func button2Tapped(_ sender: AnyObject) {
//        PHUtilities.callNumber(phoneNumber: "19732948935")
        
    }
    
    @IBAction func button3Tapped(_ sender: AnyObject) {
    }
    


}