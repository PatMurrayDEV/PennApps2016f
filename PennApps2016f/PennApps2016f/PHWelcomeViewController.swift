//
//  PHWelcomeViewController.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 9/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PHWelcomeViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var button1: HPButton!
    @IBOutlet weak var button2: HPButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        // Do any additional setup after loading the view.
        zoomToRegion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func zoomToRegion() {
        
        let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 39.995168, longitude: -75.149842), 5928*2, 5928*2)
        mapView.setRegion(region, animated: true)
        
     //   manager.requestLocation()
     //   manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
     //   manager.requestWhenInUseAuthorization()

        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            
            let toLocation: CLLocation = CLLocation(latitude: 39.995168, longitude: -75.149842)
            let fromLocation: CLLocation = location
            
            
            let distance = fromLocation.distance(from: toLocation)
            // 5928
            
            
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, distance*2, distance*2)
            
            print("\(distance)")
            
            mapView.setRegion(region, animated: true)

            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    

    @IBAction func button1Tapped(_ sender: AnyObject) {
        
        // lyft://ridetype?id=lyft&pickup[latitude]=37.764728&pickup[longitude]=-122.422999&destination[latitude]=37.7763592&destination[longitude]=-122.4242038
        
        
        // If Lyft is not installed, send the user to the Apple App Store
        let myApp = UIApplication.shared
        let lyftAppURL = NSURL(string: "lyft://ridetype?id=lyft_line&destination[latitude]=39.995168&destination[longitude]=-75.149842")!
        if myApp.canOpenURL(lyftAppURL as URL) {
            // Lyft is installed; launch it
            myApp.openURL(lyftAppURL as URL)
        } else {
            // Lyft not installed; open App Store
            let lyftAppStoreURL = NSURL(string: "https://itunes.apple.com/us/app/lyft-taxi-bus-app-alternative/id529379082")!
            myApp.openURL(lyftAppStoreURL as URL)
        }
        
    }
    
    @IBAction func button2Tapped(_ sender: AnyObject) {
        PHUtilities.callNumber(phoneNumber: "19732948935")
    }
    
    
    
    
    
    

}
