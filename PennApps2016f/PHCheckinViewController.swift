//
//  PHCheckinViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 9/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PHCheckinViewController: UIViewController {
    
    
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
        let timeStamp = NSDate().dateStringWithFormat(format: "Hmm a")
        PHUtilities.smsNumber(phoneNumber: "19732948935", message: "Harrison checked in to your property at \(timeStamp)")

        let storyboard = UIStoryboard(name: "PostCheckin", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()! as UIViewController
        present(controller, animated: true, completion: nil)
    }

    @IBAction func button2Tapped(_ sender: AnyObject) {
        PHUtilities.callNumber(phoneNumber: "19732948935")
        
    }
    
    @IBAction func button3Tapped(_ sender: AnyObject) {
    }
    
    

}


extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
    }
}
