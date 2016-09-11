//
//  ViewController.swift
//  frontdesk
//
//  Created by Harrison Weinerman on 9/10/16.
//  Copyright © 2016 harrisonweinerman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var airConditioningLabel: UILabel!
    
    @IBOutlet weak var doorLockLabel: UILabel!
    
    @IBOutlet weak var lightsLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lockImage: UIImageView!
    
    var ac = 0
    var lights = 0
    var locked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let t = Timer(timeInterval: 1, target: self, selector: #selector(fetch), userInfo: nil, repeats: true)
        
        RunLoop.current.add(t, forMode: .commonModes)
        
        fetch()
    }
    
    func fetch() {
        let db = CKContainer(identifier: "iCloud.com.harrisonweinerman.frontdesk").publicCloudDatabase
        let recordID = CKRecordID(recordName: "homeStatus")
        db.fetch(withRecordID: recordID) { fetchedRecord, error in
            if error != nil {
                print("error fetching home record" + (error?.localizedDescription)!)
            }
            else {
                print("yay fetched home record")
                print(fetchedRecord!.value(forKey: "lightsOn")!)
                
                let fetchedLights = fetchedRecord!.value(forKey: "lightsOn") as! Int
                let fetchedLocked = fetchedRecord!.value(forKey: "doorLocked") as! Int
                let fetchedAC = fetchedRecord!.value(forKey: "airConditioningOn") as! Int
                
                if fetchedLights != self.lights {
                    self.lights = fetchedLights
                    
                    if fetchedLights == 0 {
                        self.performSelector(onMainThread: #selector(self.lightsOff), with: nil, waitUntilDone: false)
                    }
                    else {
                        self.performSelector(onMainThread: #selector(self.lightsOn), with: nil, waitUntilDone: false)
                    }
                }
                
                if fetchedLocked != self.locked {
                    self.locked = fetchedLocked
                    
                    if fetchedLocked == 0 {
                        self.performSelector(onMainThread: #selector(self.unlock), with: nil, waitUntilDone: false)
                    }
                    else {
                        self.performSelector(onMainThread: #selector(self.lock), with: nil, waitUntilDone: false)
                    }
                }
                
                if fetchedAC != self.ac {
                    self.ac = fetchedAC
                    
                    if fetchedAC == 0 {
                        self.performSelector(onMainThread: #selector(self.airConditioningOff), with: nil, waitUntilDone: false)
                    }
                    else {
                        self.performSelector(onMainThread: #selector(self.airConditioningOn), with: nil, waitUntilDone: false)
                    }
                }
            }
        }
    }
    var lockSound = URL(fileURLWithPath: Bundle.main.path(forResource: "lock", ofType: "aiff")!)
    var unlockSound = URL(fileURLWithPath: Bundle.main.path(forResource: "unlock", ofType: "aiff")!)

    var audioPlayer = AVAudioPlayer()
    
    func lightsOn() {
        UIView.animate(withDuration: 0.8) {
            self.imageView.alpha = 0
        }
        lightsLabel.text = "Lights on"
    }
    
    func airConditioningOn() {
        airConditioningLabel.text = "Air conditioning on"
    }
    
    func lock() {
        doorLockLabel.text = "Door locked"
        lockImage.image = UIImage(named: "padlock-closed")

        do {
            try audioPlayer = AVAudioPlayer(contentsOf: lockSound)
        }
        catch {
            print(error)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func lightsOff() {
        UIView.animate(withDuration: 0.8) {
            self.imageView.alpha = 1
        }
        lightsLabel.text = "Lights off"
    }
    
    func airConditioningOff() {
        airConditioningLabel.text = "Air conditioning off"
    }
    
    func unlock() {
        doorLockLabel.text = "Door unlocked"
        lockImage.image = UIImage(named: "padlock-open")
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: unlockSound)
        }
        catch {
            print(error)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

