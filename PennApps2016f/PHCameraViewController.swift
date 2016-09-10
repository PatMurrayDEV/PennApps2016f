//
//  PHCameraViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 10/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit


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
