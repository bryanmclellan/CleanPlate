//
//  RewardsViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/13/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var activeTableView: UITableView!
    var restaurantNames = ["Scoop", "Cheesecake Factory", "Zola", "In-n-Out", "Tacolicious"]
    var rewardDescriptions = ["Free Single Scoop Cone", "Free Dessert with Meal", "50% off wine pairing", "Free fries", "Free taco"]
    var rewardImages = ["scoop","cheesecake-factory-logo","zola-logo","in-n-out-logo","tacoliciousicon"]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        activeTableView.delegate = self
        activeTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = activeTableView.dequeueReusableCellWithIdentifier("activeCell", forIndexPath: indexPath) as! RewardsActiveTableViewCell
        cell.rewardLabel.text = rewardDescriptions[indexPath.row]
        cell.restaurantNameLabel.text = restaurantNames[indexPath.row]
        
        let image = UIImage(named: rewardImages[indexPath.row])
        cell.rewardsActiveCellImageView.image = image
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Redeem Reward?", message: "Click OK to claim your \(rewardDescriptions[indexPath.row]) from \(restaurantNames[indexPath.row])", preferredStyle: .Alert)
        
        let QRalert = UIAlertController(title: "\(rewardDescriptions[indexPath.row])", message: "Reward Code: me856tyr90", preferredStyle: .Alert)
        
        let DoneAction = UIAlertAction(title: "Done", style: .Default) { (UIAlertAction) -> Void in
            print("clicked done")
        }
        
        let OKaction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
            print("clicked ok")
            let image = UIImage(named: "QRImage")
            let QRimageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
            QRimageView.image = image
            
            QRalert.view.addSubview(QRimageView)
            QRalert.addAction(DoneAction)
            self.presentViewController(QRalert, animated: true, completion: { () -> Void in
                // ?
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) -> Void in
            print("cancel clicked")
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(OKaction)
        
        presentViewController(alert, animated: true) { () -> Void in
            // add code to move arrays around here
        }
        
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
