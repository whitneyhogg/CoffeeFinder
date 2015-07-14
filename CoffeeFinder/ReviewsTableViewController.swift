//
//  ReviewsTableViewController.swift
//  CoffeeFinder
//
//  Created by Whitney Lauren on 7/13/15.
//  Copyright (c) 2015 Whitney Lauren. All rights reserved.
//

import UIKit
import CoreLocation

class ReviewsTableViewController: UITableViewController {
    
    var item: [[String:AnyObject]]?
    
    @IBAction func backButton(sender: UIButton) {
        
        
        var venueVC = self.storyboard?.instantiateViewControllerWithIdentifier("venueVC")
            as! VenueViewController
        
        self.presentViewController(venueVC, animated: false, completion: nil)
        
        //venue id, request with id
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        func requestReviewsWithLocation(location: CLLocation, completion: (venues: [AnyObject]) -> ()) {
            
            let apiUrl = "https://api.foursquare.com/v2/"
            let foursquareId = "NEEAYQOQJE3WHXMGFYAPORCOB34JIWSIEVKBXIE3NUDDPBYU"
            let client_secret = "M2QIQDADDASWMBXX2GCR3WQZQA3IVBBNREEWEACRYKM3SJIP"
            
            let endpoint = apiUrl + "venues/50d0277fe4b0e7c004e620df"
            
            println(endpoint)
            
            if let url = NSURL(string: endpoint) {
                
                let request = NSURLRequest(URL: url)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                    
                    print(response)
                    
                    if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                        
                      println(returnedInfo)
                        
                        if let responseInfo = returnedInfo["response"] as? [String:AnyObject] {
                            println(responseInfo)
                            
                            if let tips = responseInfo["tips"] as? [String:AnyObject] {
                                
                                println(tips)
                                
                                if let items = tips["items"] as? [[String:AnyObject]] {
                                    
                                    self.item = items
                                }
                   //             completion(venues: venueid)
                                
//                                if let  venuetips = responseInfo["tips"] as? [AnyObject] {
//                                    
//                                    println(venuetips)
//                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    
                })
                
                
            }
       
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete met
        // Return the number of rows in the section.
        return 10//item!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! ReviewTableViewCell
        
//        cell.reviewTextView.text = item![indexPath.row]["text"] as? String
        
      return cell

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

}
