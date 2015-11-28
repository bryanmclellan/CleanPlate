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
    @IBOutlet weak var descriptionLabel: UILabel!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNameLabel.text = restaurantNameText
        descriptionLabel.text = descriptionText

        // Do any additional setup after loading the view.
        
        yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("tryna go to google maps with navigation")
            if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps-x-callback://")!)) {
                
                let directionsRequest = "comgooglemaps-x-callback://" +
                    "?daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York" +
                "&x-success=sourceapp://?resume=true&x-source=AirApp"
                //let directionsURL = NSURL(string: directionsRequest)
                
                UIApplication.sharedApplication().openURL(NSURL(string: directionsRequest)!)
            } else {
                print("Can't use comgooglemaps://");
            }
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Waiting for pick up confirmation"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
        
        noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("No directions requested")
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Waiting for pick up confirmation"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        pickUpAlert.addAction(confirmAction)
        pickUpAlert.addAction(cancelAction)
        
        self.presentViewController(pickUpAlert, animated: true, completion: nil)
    }

    func onHudTap(){
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.performSegueWithIdentifier("shelterSegue", sender: self)
    }
    
    @IBAction func dismissHUD(sender: AnyObject) {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
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
