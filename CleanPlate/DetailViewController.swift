//
//  DetailViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/25/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberOfBagsLabel: UILabel!
    var restaurantNameText = ""
    var descriptionText = ""
    var hoursText = ""
    var addressText = ""
    var numberOfBagsText = ""
    var yesAction = UIAlertAction()
    var noAction = UIAlertAction()
    
    @IBOutlet weak var pickUpIconButton: UIButton!
    
    @IBOutlet weak var coverImageView: UIImageView!
    var imagesDict: [String: String] = [
        "Zola" : "zola-wide",
        "Sancho Taqueria": "sanchos-wide",
        "Darbar Indian Cuisine" : "darbar-wide",
        "Buca di Beppo": "buca-wide"
    ]
    
    var websiteDict: [String: String] = [
        "Zola" : "http://www.zolapaloalto.com",
        "Sancho Taqueria": "http://www.sanchostaqueria.com",
        "Darbar Indian Cuisine" : "http://www.darbarcuisine.com",
        "Buca di Beppo": "http://www.bucadibeppo.com"
    ]
    
    var phoneDict: [String: String] = [
        "Zola" : "tel://6505210651",
        "Sancho Taqueria": "tel://6503248226",
        "Darbar Indian Cuisine" : "tel://6503216688",
        "Buca di Beppo": "tel://6503290665"
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "2. Confirm Pickup"
        
        // Do any additional setup after loading the view.
        
        yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("tryna go to google maps with navigation")
            if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps-x-callback://")!)) {
                let myAddress = Util.sharedInstance.getRestaurantAddr()
                let myAddr = myAddress.stringByReplacingOccurrencesOfString(" ", withString: "+")
                print("my addr is \(myAddr)")
                let directionsRequest = "comgooglemaps-x-callback://" +
                    "?daddr=" + myAddr +
                "&x-success=sourceapp://?resume=true&x-source=AirApp"
                //let directionsURL = NSURL(string: directionsRequest)
                
                UIApplication.sharedApplication().openURL(NSURL(string: directionsRequest)!)
            } else {
                print("Can't use comgooglemaps://");
            }
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "\(Util.sharedInstance.getRestaurantName()) is confirming pickup"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
        
        noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("No directions requested")
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "\(Util.sharedInstance.getRestaurantName()) is confirming pickup"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
        
    }
    
    @IBAction func openWebsite(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: websiteDict[Util.sharedInstance.restaurantName]!)!)
    }
    @IBAction func makeCall(sender: AnyObject) {        
        UIApplication.sharedApplication().openURL(NSURL(string: phoneDict[Util.sharedInstance.restaurantName]!)!)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        restaurantNameLabel.text = Util.sharedInstance.restaurantName
        hoursLabel.text = Util.sharedInstance.getRestaurantHours()
        addressLabel.text = Util.sharedInstance.restaurantAddr
        
        coverImageView.image = UIImage(named: imagesDict[Util.sharedInstance.restaurantName]!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }
    
    
    @IBAction func cancelWasPressed(sender: AnyObject) {
        self.stepsController.showPreviousStep()
    }
    
    
    @IBAction func pickUpWasPressed(sender: UIButton) {
        let pickUpAlert = UIAlertController(title: "Confirm Pick Up?", message: "You are commiting to making this pick up", preferredStyle: UIAlertControllerStyle.Alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let alert = UIAlertController(title: "Get directions?", message: "Would you like directions to the restaurant?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(self.noAction)
            alert.addAction(self.yesAction)
            
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
        
        pickUpAlert.addAction(cancelAction)
        pickUpAlert.addAction(confirmAction)
        
        self.presentViewController(pickUpAlert, animated: true, completion: nil)
    }

    func onHudTap(){
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
       // self.performSegueWithIdentifier("shelterSegue", sender: self)
        self.stepsController.showNextStep()
    }
    
    @IBAction func dismissHUD(sender: AnyObject) {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    
    
    @IBAction func addToFavs(sender: AnyObject) {
        var alert = UIAlertController(title: "Added to Favorites", message: "You will now recieve notifications when \(Util.sharedInstance.getRestaurantName()) has leftover food", preferredStyle: .Alert)
        
        let doneAction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(doneAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        var favs = Util.sharedInstance.getFavRestaurantNames()
        favs.append(Util.sharedInstance.getRestaurantName())
        Util.sharedInstance.setFavRestaurantNames(favs)
        
        var images = Util.sharedInstance.getFavImages()
        images.append(imagesDict[Util.sharedInstance.getRestaurantName()]!)
        Util.sharedInstance.setFavImages(images)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
