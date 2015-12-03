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
    
    var hoursDict: [String:String] = [
        "Zola" : "Friday 5:00 – 10:00 PM",
        "Sancho Taqueria" : "Friday 10:30 AM – 9:00 PM",
        "Darbar Indian Cuisine" : "11:00 AM – 2:30 PM, 5:00 – 10:00 PM",
        "Buca di Beppo" : "11:00 AM – 11:00 PM"
    ]
    
    var addrDict: [String:String] = [
        "Zola" : "565 Bryant St, Palo Alto, CA 94301",
        "Sancho Taqueria" : "2723 Middlefield Road, Palo Alto, CA 94306",
        "Darbar Indian Cuisine" : "129 Lytton Ave, Palo Alto, CA 94301",
        "Buca di Beppo" : "643 Emerson St, Palo Alto, CA 94301"
    ]
    

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
        let camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 13)
     //   let camera = GMSCameraPosition.cameraWithLatitude(37.445605, longitude: -122.160480, zoom: 15)
        
        mapView.camera = camera
        mapView.delegate = self
        mapView.myLocationEnabled = true
        
        addMarker("Zola", snippet: "Cool, intimate locale with sidewalk seats, featuring area-sourced French cuisine & a vast wine list", lat: 37.445605, long: -122.160480)
        addMarker("Sancho Taqueria", snippet: "Mexican eatery with folkloric art on the walls & patio seating serving a menu of classic Baja fare", lat: 37.433793, long:  -122.128931)
        addMarker("Darbar Indian Cuisine", snippet: "A go-to for Stanford students looking to sample a multiregional Indian menu in casual quarters", lat: 37.445035, long: -122.165181)
        addMarker("Buca di Beppo", snippet: "Chain serving family-style Italian fare in a kitschy setting featuring red-and-white tablecloths", lat:  37.443642, long: -122.160470)
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
        marker.snippet = snippet + "\n" + "3 bags to pick up"
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
        print("clicked window")
       // self.performSegueWithIdentifier("detailSegue", sender: marker)
        let detailVC = self.stepsController.stepViewControllers()[1] as! DetailViewController
        Util.sharedInstance.restaurantName = marker.title
        Util.sharedInstance.restaurantHours = hoursDict[marker.title]!
        Util.sharedInstance.restaurantAddr = addrDict[marker.title]!
        
     //   detailVC.hoursText = marker.snippet
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
