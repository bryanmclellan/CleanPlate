//
//  LandingViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/13/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit
import GoogleMaps

class LandingViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom:7)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        mapView.delegate = self
        self.view = mapView
        
        mapView.myLocationEnabled = true
        
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2DMake(37.445605, -122.160480)
        marker.title = "Zola"
        marker.snippet = "Seasonal French Food"
        marker.map = mapView


        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        

        
    
        
        
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps-x-callback://")!)) {
            
            let directionsRequest = "comgooglemaps-x-callback://" +
                "?daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York" +
                "&x-success=sourceapp://?resume=true&x-source=AirApp"
            //let directionsURL = NSURL(string: directionsRequest)
            
         //   UIApplication.sharedApplication().openURL(NSURL(string: directionsRequest)!)   -----------------------use to open up navigation
        } else {
            print("Can't use comgooglemaps://");
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got dat location doe")
        let curLoc = locations.last
        locations.last?.coordinate.latitude
        let camera =  GMSCameraPosition.cameraWithLatitude((curLoc?.coordinate.latitude)!, longitude: (curLoc?.coordinate.longitude)!, zoom: 5)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        print("here!!")
        self.performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        var image  = UIImage(named: "AppIcon")
        return UIImageView(image: image)
    }
    

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
