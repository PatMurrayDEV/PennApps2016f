//
//  HWDuringStayViewController.swift
//  PennApps2016f
//
//  Created by Harrison Weinerman on 9/10/16.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class HWDuringStayViewController: UIViewController {

    @IBOutlet weak var placeholderView: UIView!
    
    @IBOutlet weak var contact: UIButton!
    
    @IBOutlet weak var change: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contact.layer.cornerRadius = contact.frame.size.height / 2
        contact.layer.masksToBounds = true
        
        change.layer.cornerRadius = contact.frame.size.height / 2
        change.layer.masksToBounds = true
        
        placeholderView.layer.cornerRadius = contact.frame.size.height / 2
        placeholderView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
