//
//  VenueViewController.swift
//  CoffeeFinder
//
//  Created by Whitney Lauren on 7/8/15.
//  Copyright (c) 2015 Whitney Lauren. All rights reserved.
//

import UIKit
import CoreLocation

class VenueViewController: UIViewController {
    
    var venueInfo: [String:AnyObject]?
    
    @IBAction func createReview(sender: UIButton) {
        
        var storyboard = UIStoryboard(name: "Review", bundle: nil)
        
        var createNVC = storyboard.instantiateInitialViewController() as! UINavigationController
        
        self.presentViewController(createNVC, animated: false, completion: nil)
    }
    
    @IBAction func reviewButton(sender: UIButton) {
        
        var reviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("reviewVC")
            as! ReviewViewController
        
        self.presentViewController(reviewVC, animated: false, completion: nil)
        
    }
    
    @IBAction func resultsButton(sender: UIButton) {
        
        var resultsVC = self.storyboard?.instantiateViewControllerWithIdentifier("resultsVC")
            as! ResultsViewController
        
        self.presentViewController(resultsVC, animated: false, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var flagImage: UIButton!
    
    
    
    
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var nameInfo: UILabel!
    @IBOutlet weak var addressInfo: UILabel!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameInfo.text = venueInfo?["name"] as? String
        addressInfo.text = venueInfo?["address"] as? String
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

}
