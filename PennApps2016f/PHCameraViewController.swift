//
//  PHCameraViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 10/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PHCameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var button1: HPButton!
    @IBOutlet weak var button2: HPButton!
    @IBOutlet weak var button3: UIButton!
    
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetHigh
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            stillImageOutput = AVCapturePhotoOutput()
//            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if session!.canAddOutput(stillImageOutput) {
                session!.addOutput(stillImageOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                view.layer.insertSublayer(videoPreviewLayer!, at:0)
                session!.startRunning()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = view.bounds
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
    
    
    func takePhoto(){
        
        
            
        let connection = self.stillImageOutput?.connection(withMediaType: AVMediaTypeVideo)
        
        // update the video orientation to the device one
        connection?.videoOrientation = AVCaptureVideoOrientation(rawValue: UIDevice.current.orientation.rawValue)!
        
        self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(connection: connection) {
            (imageDataSampleBuffer, error) -> Void in
            
            if error == nil {
                
                // if the session preset .Photo is used, or if explicitly set in the device's outputSettings
                // we get the data already compressed as JPEG
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                
                // the sample buffer also contains the metadata, in case we want to modify it
                let metadata:NSDictionary = CMCopyDictionaryOfAttachments(nil, imageDataSampleBuffer, CMAttachmentMode(kCMAttachmentMode_ShouldPropagate)).takeUnretainedValue()
                
                if let image = UIImage(data: imageData) {
                    // save the image or do something interesting with it
                    
                }
            }
            else {
                NSLog("error while capturing still image: \(error)")
            }
        }
        
        
    }

}
