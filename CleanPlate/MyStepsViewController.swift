//
//  MyStepsViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/30/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class MyStepsViewController: RMStepsController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepsBar.hideCancelButton = true

        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.barTintColor = UIColor(red: 66/255.0, green: 165/255.0, blue: 245/255.0, alpha: 1.0)
        let image = UIImage(named: "Icon-72")
        let imageViewLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewLogo.contentMode = .ScaleAspectFit
        imageViewLogo.image = image
        
        self.navigationItem.titleView = imageViewLogo

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func stepViewControllers() -> [AnyObject]! {
        let first = self.storyboard?.instantiateViewControllerWithIdentifier("Landing")
        first!.step.title = "Select your restaurant"
        
        
        let second = self.storyboard?.instantiateViewControllerWithIdentifier("Detail")
        second!.step.title = "Commit to pick up leftover food"
        
        
        let third = self.storyboard?.instantiateViewControllerWithIdentifier("Shelter")
        third!.step.title = "Find and deliver to shelter"
        
//        let fourth = self.storyboard?.instantiateViewControllerWithIdentifier("Reward") as! RewardsViewController
//        fourth.step.title = "Claim the reward"
//        fourth.cameFromShelter = true
        
        return [first!, second!, third!]
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
