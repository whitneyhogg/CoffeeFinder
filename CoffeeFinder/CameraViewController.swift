//
//  CameraViewController.swift
//  CoffeeFinder
//
//  Created by Whitney Lauren on 7/2/15.
//  Copyright (c) 2015 Whitney Lauren. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    //for zoom function?
    @IBOutlet var scrollView : UIScrollView!
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker, animated: false, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let size = CGSize(width: image.size.width / 2, height: image.size.height / 2)
            
            let resizedImage = resizeImage(image, withSize: size)
            
            S3ImageRequest().saveImageToS3(resizedImage)
            
            UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil)

        }
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func resizeImage (image:UIImage, withSize newSize:CGSize) -> UIImage {
        
        var scaleImageRect = CGRectMake(0, 0, newSize.width, newSize.height)
    
        if (newSize.height / newSize.width != image.size.height / image.size.width) {
    
          if (image.size.height > image.size.width) {
            
                var ratio = newSize.width / image.size.width;
                var newHeight = ratio * image.size.height;
                var newY = (newSize.height - newHeight) / 2;
                scaleImageRect = CGRectMake(0, newY, newSize.width, newHeight);
    
            } else {
    
                var ratio = newSize.height / image.size.height;
                var newWidth = ratio * image.size.width;
                var newX = (newSize.width - newWidth) / 2;
                scaleImageRect = CGRectMake(0, newX, newWidth, newSize.height);
    
    
    
            }
    
        }
    
        UIGraphicsBeginImageContext(newSize)
        
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    
       
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
    
        UIGraphicsEndImageContext()
    
        return newImage
    
    }

    
}















