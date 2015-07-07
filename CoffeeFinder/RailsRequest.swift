//
//  RailsRequest.swift
//  CoffeeFinder
//
//  Created by Whitney Lauren on 7/2/15.
//  Copyright (c) 2015 Whitney Lauren. All rights reserved.
//

import Foundation
private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = RailsRequest()

let API_URL = "https://pacific-atoll-5255.herokuapp.com/"


class RailsRequest: NSObject {
    
    class func session() -> RailsRequest { return _singleton }
    
    var token: String? {
        
        get {
            
            return defaults.objectForKey("TOKEN") as? String
            
        }
        
        set {
            
            defaults.setValue(newValue, forKey: "TOKEN")
            defaults.synchronize()
            
        }
    }
   
    
    var username: String?
    var email: String?
    var password: String?
    var imageURL: String?
    var text: String?
    var reviewid: Int!
    
    //begin repeated stuff
    func registerWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "users/signup",
            "parameters" : [
                
                "username" : username!,
                "email" : email!,
                "password" : password!,
             
                
            ]
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                //end repeated stuff
                
            }
            
        })
        
        completion()
        
    }
    
    func loginWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "users/login",
            "parameters" : [
                
                "username" : username!,
                "password" : password!
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }

    func createReviewWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "image" : "https://coffeecollection.s3.amazonaws.com/myImage_1435934260.png",
                "text" : text!
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    
    func deleteReviewWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "reviewid" : reviewid!,
                
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    //figure out parameters
    func flagReviewWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "reviewid" : reviewid!,
               
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    
    //figure out parameters
    func deleteUserWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "username" : username!,
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    
    
    func updateUserWithCompletion(completion: () -> Void) {
        
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "username" : username!,
                "password" : password!,
                "email" : email!
                
            ]
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
        completion()
        
    }
    
    
    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: AnyObject?) -> Void)?) {
        
        let endpoint = info["endpoint"] as! String
        
        if let url = NSURL(string: API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            if let token = token {
                
                request.setValue(token, forHTTPHeaderField: "access_token")
            }
            

            
            if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
                
                let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
                
                let postLength = "\(jsonString!.length)"
                
                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                
                let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.HTTPBody = postData
                
            }
            
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                
                if let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) {
                    
                    completion?(responseInfo: json)
                    
                }
                
            })
            
        }
        
    }
    
}
