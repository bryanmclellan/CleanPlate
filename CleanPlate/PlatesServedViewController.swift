//
//  PlatesServedViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 12/2/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class PlatesServedViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
 
    @IBOutlet weak var graphImageView: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    @IBAction func indexChanged(sender: AnyObject) {
        if segment.selectedSegmentIndex == 0 {
            graphImageView.image = UIImage(named: "Global Graph")
        }
        else{
            graphImageView.image = UIImage(named: "Personal Graph")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.barTintColor = UIColor(red: 66/255.0, green: 165/255.0, blue: 245/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        menuButton.image = UIImage(named: "ic_list_2x")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
