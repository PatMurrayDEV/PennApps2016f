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
//        https://rest.nexmo.com/sms/json?from=12016215775&to=12022909517&text=HELLLLOOOO&api_key=dccb2143&api_secret=7aefd95414dc5684
        
        let stringURL = "https://rest.nexmo.com/sms/json?from=12016215775&to=\(phoneNumber)&text=\(message)&api_key=dccb2143&api_secret=7aefd95414dc5684"
        
        let newString = stringURL.replacingOccurrences(of: " ", with: "%20")
        

        let url = NSURL(string: newString)
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url as! URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            
        }
        
   //     task.resume()

        
        
    }
    
    

}



