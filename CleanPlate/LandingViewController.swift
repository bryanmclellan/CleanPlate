//
//  LandingViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/13/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit
import GoogleMaps

class LandingViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var stepBar: RMStepsBar!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var markers:[GMSMarker] = [GMSMarker]()
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "1. Find a restaurant"
        
        searchBar.delegate = self
        let camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 14)
        
        mapView.camera = camera
        mapView.delegate = self
        mapView.myLocationEnabled = true
        
        addMarker("Zola", snippet: "Seasonal French Cooking", lat: 37.445605, long: -122.160480)
        addMarker("Scoop Microcreamery", snippet: "Cute counter-serve sweet shop ", lat: 37.446868, long: -122.162683)
        addMarker("Cheesecake Factory", snippet: "American Dining Chain with jumbo plates", lat: 37.448880, long: -122.160925)
        addMarker("Tacolicious", snippet: "Creative Mexican taqueria and tequila bar", lat: 37.443617, long: -122.161181)
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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got dat location doe")
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        print("here!!")
       // self.performSegueWithIdentifier("detailSegue", sender: marker)
        print(" here we go \(self.stepsController)")
        self.stepsController.showNextStep()
        
    }
    
//    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
//        let image  = UIImage(named: "AppIcon")
//        return UIImageView(image: image)
//    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
            }
    

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        searchBar.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            let marker = sender as! GMSMarker
            
            detailVC.restaurantNameText = marker.title
            detailVC.descriptionText = marker.snippet
        }
        
    }
    

}
