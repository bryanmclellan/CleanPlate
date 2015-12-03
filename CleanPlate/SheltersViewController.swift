//
//  SheltersViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/27/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit
import GoogleMaps

class SheltersViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var markers:[GMSMarker] = [GMSMarker]()
    
    var yesAction = UIAlertAction()
    var noAction = UIAlertAction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "3. Find a shelter"
        searchBar.delegate = self
        let camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 14)
        
        mapView.camera = camera
        mapView.delegate = self
        mapView.myLocationEnabled = true
        
        addMarker("Shelter 1", snippet: "Seasonal French Cooking", lat: 37.445605, long: -122.160480)
        addMarker("Shelter 2", snippet: "Cute counter-serve sweet shop ", lat: 37.446868, long: -122.162683)
        addMarker("Shelter 3", snippet: "American Dining Chain with jumbo plates", lat: 37.448880, long: -122.160925)
        addMarker("Shelter 4", snippet: "Creative Mexican taqueria and tequila bar", lat: 37.443617, long: -122.161181)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

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
            hud.labelText = "Waiting for delivery confirmation"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
        
        noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            print("No directions requested")
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "Waiting for delivery confirmation"
            let tap = UITapGestureRecognizer(target: self, action: "onHudTap")
            hud.addGestureRecognizer(tap)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMarker(title: String, snippet: String, lat: CLLocationDegrees, long: CLLocationDegrees){
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = title
        marker.snippet = snippet + "\n" + "4 bags to pick up"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        markers.append(marker)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        for var m in markers{
            let lowerTitle = m.title.lowercaseString
            let lowerSearch = searchText.lowercaseString
            if !lowerTitle.containsString(lowerSearch) && searchText != ""{
                m.map = nil
            }
            else{
                if(m.map == nil){
                    m.map = mapView
                }
            }
        }
    }
    
    func onHudTap(){
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
       // self.performSegueWithIdentifier("shelterSegue", sender: self)
        let alert = UIAlertController(title: "Claim Reward", message: "You have got a new reward. Check it out!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.performSegueWithIdentifier("rewardSegue", sender: self)
          //  self.stepsController.showNextStep()
        }
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        searchBar.endEditing(true)
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        let alert = UIAlertController(title: "Confirm delivery?", message: "Click ok to confirm that you will deliver to this shelter", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in

            let directionsAlert = UIAlertController(title: "Get directions?", message: "Would you like directions to the restaurant?", preferredStyle: UIAlertControllerStyle.Alert)
            
            directionsAlert.addAction(self.noAction)
            directionsAlert.addAction(self.yesAction)
            
            self.presentViewController(directionsAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "rewardSegue" {
            let rewardVC = segue.destinationViewController as! RewardsViewController
            rewardVC.cameFromShelter = true
        }
    }


}
