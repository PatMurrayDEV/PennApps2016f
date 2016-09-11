//
//  PHFinalViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 11/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

import CloudKit

class PHFinalViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var button1: HPButton!
    @IBOutlet weak var button3: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // manager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func button1Tapped(_ sender: AnyObject) {
        
        // lyft://ridetype?id=lyft&pickup[latitude]=37.764728&pickup[longitude]=-122.422999&destination[latitude]=37.7763592&destination[longitude]=-122.4242038
        
        
        // If Lyft is not installed, send the user to the Apple App Store
        let myApp = UIApplication.shared
        let lyftAppURL = NSURL(string: "lyft://ridetype?id=lyft_line")!
        if myApp.canOpenURL(lyftAppURL as URL) {
            // Lyft is installed; launch it
            myApp.openURL(lyftAppURL as URL)
        } else {
            // Lyft not installed; open App Store
            let lyftAppStoreURL = NSURL(string: "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082")!
            myApp.openURL(lyftAppStoreURL as URL)
        }
        
    }

    
    
    @IBAction func button3Tapped(_ sender: AnyObject) {
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateInitialViewController()! as UIViewController
    self.present(controller, animated: true, completion: nil)
    
        }
    }
    
    

}
