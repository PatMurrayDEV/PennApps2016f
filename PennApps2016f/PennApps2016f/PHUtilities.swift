//
//  PHUtilities.swift
//  PennApps2016f
//
//  Created by Patrick Murray on 10/09/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PHUtilities: NSObject {
    

    class func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
    class func smsNumber(phoneNumber:String, message:String) {
//        https://rest.nexmo.com/sms/json?from=XXX&to=XXX&text=HELLLLOOOO&api_key=XXX&api_secret=XXX
        
        
        let stringURL = "https://rest.nexmo.com/sms/json?from=XXXX&to=\(phoneNumber)&text=\(message) &api_key=XXXX&api_secret=XXXXX"
        
        let newString = stringURL.replacingOccurrences(of: " ", with: "%20")
        

        let url = NSURL(string: newString)
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url as! URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            print(response)
            
        }
        
        task.resume()

        
        
    }
    
    

}



