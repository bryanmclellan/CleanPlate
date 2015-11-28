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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNameLabel.text = restaurantNameText
        descriptionLabel.text = descriptionText

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickUpWasPressed(sender: UIButton) {
            
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
