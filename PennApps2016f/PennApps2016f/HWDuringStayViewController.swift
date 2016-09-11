//
//  HWDuringStayViewController.swift
//  PennApps2016f
//
//  Created by Harrison Weinerman on 9/10/16.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import CoreLocation
//import GooglePlaces

struct place {
    var name : String
    var imageURL : URL
    var distance : String
}

class HWDuringStayViewController: UIViewController {
    
    @IBOutlet weak var contact: UIButton!
    
    @IBOutlet weak var change: UIButton!
    
    @IBOutlet weak var nearbyImageView: UIImageView!
    @IBOutlet weak var nearbyCaption: UILabel!
    
    var results : [[String : AnyObject]] = []
    
    var image = UIImage()
    
    
    var lat: String = ""
    var long : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        contact.layer.cornerRadius = contact.frame.size.height / 2
//        contact.layer.masksToBounds = true
//        
//        change.layer.cornerRadius = contact.frame.size.height / 2
//        change.layer.masksToBounds = true
        
      //  locManager.delegate = self
      //  locManager.desiredAccuracy = kCLLocationAccuracyBest
      //  locManager.requestWhenInUseAuthorization()
      //  locManager.startMonitoringSignificantLocationChanges()
        
        // Check if the user allowed authorization
       // if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
         //   CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        //{
            
            let search = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.995168,-75.149842&radius=500&type=restaurant&key=AIzaSyCk-laMzz7nwobXmg3NHUCyg8PaAFe_Jrk"

            
            let searchURL = URL(string: search);
            var request = URLRequest(url: searchURL!)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                
                if error != nil {
                    print(error!.localizedDescription)
                    DispatchQueue.main.sync(execute: {
                        print("cry network")
                    })
                    
                    return
                }
                
            
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            
                self.results = json["results"] as! [[String : AnyObject]]
             
                self.performSelector(onMainThread: #selector(self.downloadImage), with: nil, waitUntilDone: true)
                
               // print(urlCall)
                
                
         /*       let top3 = [results[0], results[1], results[2]]
                
                for result in top3 {
                    
                    
                    
                    /*place(name: result["name"] as! String,
                          imageURL: <#T##URL#>,
                          distance: <#T##String#>)*/
                } */
                
                //print(results!)
                
            } catch {
                print("cry! :( error serializing JSON: \(error)")
            }
            }

            
            task.resume()
            


            
        //}
        //else {
         //not authorized, cry instead
        //}
        
        
        // Do any additional setup after loading the view.
    }
    
    func downloadImage() {
        let ref = (self.results[0]["photos"] as! [[String : AnyObject]])[0]["photo_reference"] as! String
        
        let urlCall = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=" + ref + "&key=AIzaSyCk-laMzz7nwobXmg3NHUCyg8PaAFe_Jrk"
        
        let imageURL = URL(string: urlCall);
        var imageRequest = URLRequest(url: imageURL!)
        imageRequest.httpMethod = "GET"
        
        let imageTask = URLSession.shared.dataTask(with: imageRequest) {
            data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.sync(execute: {
                    print("cry network image")
                })
                
                return
            }
            
            if let imageData = data {
                self.image = UIImage(data: imageData)!
                self.performSelector(onMainThread: #selector(self.insertContent), with: nil, waitUntilDone: false)

            }
            else {
                print("img no data")
            }
        }
        
        imageTask.resume()
    }
    
    func insertContent() {
//        print(results)
        if let name = results[0]["name"]! as? String {
            nearbyCaption.text = "Visit \(name)"
        }
        print()
        

        
        let geo = results[0]["geometry"] as! [String : AnyObject]
        let coords = geo["location"] as! [String : AnyObject]
        self.lat = String(coords["lat"] as! Double)
        self.long = String(coords["lng"] as! Double)
        
        
        nearbyImageView.image = image
        //loadFirstPhotoForPlace(placeID: results[0]["id"]! as! String)
    }
    
    /*
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
                else {
                    print("problem")
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared()
            .loadPlacePhoto(photoMetadata, constrainedTo: nearbyImageView.bounds.size,
                            scale: self.nearbyImageView.window!.screen.scale) { (photo, error) -> Void in
                                if let error = error {
                                    // TODO: handle the error.
                                    print("Error: \(error)")
                                } else {
                                    self.nearbyImageView.image = photo;
                                    //self.attributionTextView.attributedText = photoMetadata.attributions;
                                }
        }
    }
    
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func getLyftButtonTapped(_ sender: AnyObject) {
        let myApp = UIApplication.shared
        let lyftAppURL = NSURL(string: "lyft://ridetype?id=lyft_line&destination[latitude]=\(self.lat)&destination[longitude]=\(self.long)")!
        if myApp.canOpenURL(lyftAppURL as URL) {
            // Lyft is installed; launch it
            myApp.openURL(lyftAppURL as URL)
        } else {
            // Lyft not installed; open App Store
            let lyftAppStoreURL = NSURL(string: "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082")!
            myApp.openURL(lyftAppStoreURL as URL)
        }

    }
    

    @IBAction func callHost(_ sender: AnyObject) {
        PHUtilities.callNumber(phoneNumber: "12022909517")
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
