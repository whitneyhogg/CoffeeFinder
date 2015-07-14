//
//  VenueViewController.swift
//  CoffeeFinder
//
//  Created by Whitney Lauren on 7/8/15.
//  Copyright (c) 2015 Whitney Lauren. All rights reserved.
//

import UIKit
import CoreLocation

class VenueViewController: UIViewController, UIImagePickerControllerDelegate {
    
    var venueInfo: [String:AnyObject]?
    var venueID: String?
    
    @IBAction func createReview(sender: UIButton) {
        
        var storyboard = UIStoryboard(name: "Review", bundle: nil)
        
        
        var reviewVC = storyboard.instantiateInitialViewController() as! UINavigationController
        
        self.presentViewController(reviewVC, animated: true, completion: nil)
        
    }
    
    @IBAction func reviewButton(sender: UIButton) {
        
        var reviewsTVC = self.storyboard?.instantiateViewControllerWithIdentifier("readreviewVC")
            as! ReviewsTableViewController
        
        reviewsTVC.venueID = venueID
        
        self.presentViewController(reviewsTVC, animated: false, completion: nil)
        
    }
    
    @IBAction func resultsButton(sender: UIButton) {
        
        var resultsVC = self.storyboard?.instantiateViewControllerWithIdentifier("resultsVC")
            as! ResultsViewController
        
        self.presentViewController(resultsVC, animated: false, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var flagImage: UIButton!
    
    
        
    
    
    @IBOutlet weak var venueImage:
        UIImageView!
    
    
    let imagePicker = UIImagePickerController()
    
  
    
    
    @IBOutlet weak var nameInfo: UILabel!
    @IBOutlet weak var addressInfo: UILabel!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        nameInfo.text = venueInfo?["name"] as? String
        venueID = venueInfo?["id"] as? String
        print("This is venueID \(venueID)")
        addressInfo.text = venueInfo?["address"] as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

}
