//
//  HPGettingReadyViewController.swift
//  PennApps2016f
//
//  Created by Harrison Weinerman on 9/9/16.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import CloudKit

class HPGettingReadyViewController: UIViewController {
    @IBOutlet weak var dot1: UILabel!
    @IBOutlet weak var dot2: UILabel!
    @IBOutlet weak var dot3: UILabel!

    @IBOutlet weak var hostCheckmark: CheckMarkButton!
    @IBOutlet weak var lightCheckmark: CheckMarkButton!
    @IBOutlet weak var doorCheckmark: CheckMarkButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempCheckmark: CheckMarkButton!
    
    @IBOutlet weak var hostLabel: UILabel!
    
    
    @IBOutlet weak var allSet: UILabel!
    @IBOutlet weak var lightsLabel: UILabel!
    @IBOutlet weak var doorLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dot1.transform = CGAffineTransform(translationX: 0, y: -50)
        dot2.transform = CGAffineTransform(translationX: 0, y: -50)
        dot3.transform = CGAffineTransform(translationX: 0, y: -50)
        
        self.doorCheckmark.showAnimation = false
        self.lightCheckmark.showAnimation = false
        self.hostCheckmark.showAnimation = false
        self.tempCheckmark.showAnimation = false

        self.doorCheckmark.isHidden = true
        self.lightCheckmark.isHidden = true
        self.hostCheckmark.isHidden = true
        self.tempCheckmark.isHidden = true
        
        hostLabel.alpha = 0
        lightsLabel.alpha = 0
        doorLabel.alpha = 0
        allSet.alpha = 0
        tempLabel.alpha = 0
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateDown() {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [UIViewAnimationOptions.curveEaseInOut, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat],
                        animations: {
                        self.dot1.transform = CGAffineTransform.identity
                        
        })
        UIView.animate(withDuration: 0.5,
                       delay: 0.2,
                       options: [UIViewAnimationOptions.curveEaseInOut, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat],
                       animations: {
                        self.dot2.transform = CGAffineTransform.identity
                        
        })
        UIView.animate(withDuration: 0.5,
                       delay: 0.4,
                       options: [UIViewAnimationOptions.curveEaseInOut, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat],
                       animations: {
                        self.dot3.transform = CGAffineTransform.identity
                        
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        //self.animateBack()
        }
    }
    
    func animateBack() {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.dot1.transform = CGAffineTransform(translationX: 0, y: -50)
                        
        })
        UIView.animate(withDuration: 0.3,
                       delay: 0.2,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.dot2.transform = CGAffineTransform(translationX: 0, y: -50)
                        
        })
        UIView.animate(withDuration: 0.3,
                       delay: 0.4,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.dot3.transform = CGAffineTransform(translationX: 0, y: -50)
                        
        })
        
        animateDown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        animateDown()
        //let zoneID = CKRecordZoneID(zoneName: "defaultZone", ownerName: "owner")
        let recordID = CKRecordID(recordName: "homeStatus")
        let record = CKRecord(recordType: "home", recordID: recordID)
        
        record.setValue(true, forKey: "lightsOn")
        record.setValue(false, forKey: "doorLocked")
        record.setValue(true, forKey: "airConditioningOn")
        
        
        let mod = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        mod.savePolicy = .allKeys
        mod.qualityOfService = .userInitiated
        let db = CKContainer(identifier: "iCloud.com.harrisonweinerman.frontdesk").publicCloudDatabase

        db.add(mod) 
        
        
        
        /*
        db.save(record) { (record, error) in
            if error != nil {
                print("error happened :(" + (error?.localizedDescription)!)
                
            }
            else {
            print("finished saving record")
            }
        }
        */

        
        
        UIView.animate(withDuration: 0.2,
                       delay: 1,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
                        self.hostLabel.alpha = 1
                        self.hostCheckmark.showAnimation = true
                        
        })
        
        UIView.animate(withDuration: 0.2,
                       delay: 2,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
                        self.lightsLabel.alpha = 1
                        self.lightCheckmark.showAnimation = true
                        
        })
        
        UIView.animate(withDuration: 0.2,
                       delay: 3,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
                        self.tempLabel.alpha = 1
                        self.tempCheckmark.showAnimation = true
                        
        })
        
        UIView.animate(withDuration: 0.2,
                       delay: 4,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
                        self.doorLabel.alpha = 1
                        self.doorCheckmark.showAnimation = true
                        
        })
        
        UIView.animate(withDuration: 0.2,
                       delay: 5,
                       options: UIViewAnimationOptions.autoreverse,
                       animations: {
                        self.allSet.alpha = 1
                        self.allSet.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hostCheckmark.isHidden = false
            self.hostCheckmark.showAnimation = true
 
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.lightCheckmark.isHidden = false
            self.lightCheckmark.showAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tempCheckmark.isHidden = false
            self.tempCheckmark.showAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.doorCheckmark.isHidden = false
            self.doorCheckmark.showAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            self.performSegue(withIdentifier: "checkDamageSegue", sender: self)
        }
        
        
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
