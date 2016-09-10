//
//  PHCameraViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 10/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import CloudKit

class PHCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var button1: HPButton!
    @IBOutlet weak var button2: HPButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage? = UIImage()
    
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        button1.isUserInteractionEnabled = false
        button1.alpha = 0.4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func button1Tapped(_ sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: {})
            } else {
                //                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            //            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
        
    }
    
    @IBAction func button2Tapped(_ sender: AnyObject) {
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func button3Tapped(_ sender: AnyObject) {
        
    }
    
    
    
    //---------------------------
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Got an image")
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            /*
            let record = CKRecord(recordType: "ImageReport")
          //  record.setValue(pickedImage, forKey: "image")
            
            let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
            let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
            if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true) {
                if paths.count > 0 {
                    if let dirPath = paths[0] as? String {
                        let writePath = dirPath.stringByAppendingPathComponent("Image2.png")
                        UIImagePNGRepresentation(ImageToSave).writeToFile(writePath, atomically: true)
                        
                        var File : CKAsset?  = CKAsset(fileURL: NSURL(fileURLWithPath: writePath))
                        newRecord.setValue(File, forKey: "Image")
                        
                    }
                }
            }
            
            if let database = self.privateDatabase {
                database.saveRecord(newRecord, completionHandler: { (record:CKRecord!, error:NSError! ) in
                    if error != nil {
                        NSLog(error.localizedDescription)
                    } else {
                        dispatch_async(dispatch_get_main_queue()) {
                            println("finished")
                        }
                    }
                })
            }
            
 */
            
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            imageView.image = pickedImage
        }
        imagePicker.dismiss(animated: true, completion: {
            // Anything you want to happen when the user saves an image
            self.button1.isUserInteractionEnabled = true
            self.button1.alpha = 1.0
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User canceled image")
        dismiss(animated: true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
}
