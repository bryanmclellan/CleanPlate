//
//  RewardsViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/13/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {

    
    @IBOutlet weak var ActiveOrRedeemSegControl: UISegmentedControl!
    
    @IBOutlet weak var redeemedTableView: UITableView!
    
    @IBOutlet weak var QRView: UIView!
    
    @IBOutlet weak var QRLabel: UILabel!
    @IBOutlet weak var activeTableView: UITableView!
    var restaurantNames = [String]()
    var rewardDescriptions = [String]()
    var rewardImages = [String]()
    
    var redeemedNames = [String]()
    var redeemedDescriptions = [String]()
    var redeemedImages = [String]()
    
    var cameFromShelter = false
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().delegate = self
        
        restaurantNames = Util.sharedInstance.getRewardActiveRestaurantNames()
        rewardDescriptions = Util.sharedInstance.getRewardActiveDescriptions()
        rewardImages = Util.sharedInstance.getRewardActiveImages()
        
        redeemedNames = Util.sharedInstance.getRedeemedNames()
        redeemedDescriptions = Util.sharedInstance.getRedeemedDescriptions()
        redeemedImages = Util.sharedInstance.getRedeemedImages()
        
        
//        if !cameFromShelter {
//            print("moving up")
//            self.activeTableView.frame = CGRect(x: self.activeTableView.frame.origin.x, y: self.activeTableView.frame.origin.y-44, width: self.activeTableView.frame.width, height: self.activeTableView.frame.height)
//        }
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        activeTableView.delegate = self
        activeTableView.dataSource = self
        redeemedTableView.delegate = self
        redeemedTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        alphaOutSubviews(activeTableView, value: 1)
        self.view.bringSubviewToFront(activeTableView)
        alphaOutSubviews(redeemedTableView,value: 0)
        // Do any additional setup after loading the view.
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == activeTableView{
            return restaurantNames.count
        }
        else {
            return redeemedNames.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func segControlSwitch(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            alphaOutSubviews(redeemedTableView, value: 1)
            self.view.bringSubviewToFront(redeemedTableView)
            alphaOutSubviews(activeTableView,value: 0)
        }
        else {
            alphaOutSubviews(activeTableView, value: 1)
            self.view.bringSubviewToFront(activeTableView)
            alphaOutSubviews(redeemedTableView, value: 0)
        }
    }
    
    func alphaOutSubviews(view: UIView, value: CGFloat){
        for var s in view.subviews{
            s.alpha = value
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = RewardsActiveTableViewCell()
        if tableView == activeTableView{
            cell = activeTableView.dequeueReusableCellWithIdentifier("activeCell", forIndexPath: indexPath) as! RewardsActiveTableViewCell
            cell.rewardLabel.text = rewardDescriptions[indexPath.row]
            cell.restaurantNameLabel.text = restaurantNames[indexPath.row]
            
            let image = UIImage(named: rewardImages[indexPath.row])
            
            cell.rewardsActiveCellImageView.layer.borderWidth = 1
            cell.rewardsActiveCellImageView.layer.masksToBounds = false
            cell.rewardsActiveCellImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.rewardsActiveCellImageView.layer.cornerRadius = 10
            cell.rewardsActiveCellImageView.clipsToBounds = true
            cell.rewardsActiveCellImageView.image = image
            
            cell.timeLabel.text = "Expires: Dec 12"
            cell.timeLabel.textColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        }
        else {
            cell = activeTableView.dequeueReusableCellWithIdentifier("activeCell", forIndexPath: indexPath) as! RewardsActiveTableViewCell
            cell.rewardLabel.text = redeemedDescriptions[indexPath.row]
            cell.restaurantNameLabel.text = redeemedNames[indexPath.row]
            
            let image = UIImage(named: redeemedImages[indexPath.row])
            
            cell.rewardsActiveCellImageView.layer.borderWidth = 1
            cell.rewardsActiveCellImageView.layer.masksToBounds = false
            cell.rewardsActiveCellImageView.layer.borderColor = UIColor.blackColor().CGColor
            cell.rewardsActiveCellImageView.layer.cornerRadius = 10
            cell.rewardsActiveCellImageView.clipsToBounds = true
            cell.rewardsActiveCellImageView.image = image
           
            cell.timeLabel.hidden = true
//            cell.timeLabel.text = "Expires: Dec 12"
//            cell.timeLabel.textColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        }
        
        return cell
    }
    
    @IBAction func DonePressed(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let subviews = self.view.subviews
            for var s in subviews {
                s.alpha = 1
            }
            self.view.sendSubviewToBack(self.QRView)
        })
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == redeemedTableView {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            return
        }
        let alert = UIAlertController(title: "Redeem Reward?", message: "Click OK to claim your \(rewardDescriptions[indexPath.row]) from \(restaurantNames[indexPath.row])", preferredStyle: .Alert)
        
        let OKaction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
            print("clicked ok")
            
            self.QRLabel.text = self.rewardDescriptions[indexPath.row]
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                let subviews = self.view.subviews
                for var s in subviews {
                    if (s != self.QRView){
                     s.alpha = 0.80
                    }
                }
                
                self.view.bringSubviewToFront(self.QRView)
            })
            self.removeActiveAddToRedeemed(indexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) -> Void in
            print("cancel clicked")
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(OKaction)
        
        presentViewController(alert, animated: true) { () -> Void in
            // add code to move arrays around here
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func removeActiveAddToRedeemed(index: Int) {
        
        redeemedNames.append(restaurantNames.removeAtIndex(index))
        Util.sharedInstance.setRewardActiveRestaurantNames(restaurantNames)
        Util.sharedInstance.setRedeemedNames(redeemedNames)
        
        redeemedDescriptions.append(rewardDescriptions.removeAtIndex(index))
        Util.sharedInstance.setRewardActiveDescriptions(rewardDescriptions)
        Util.sharedInstance.setRedeemedDescriptions(redeemedDescriptions)
        
        redeemedImages.append( rewardImages.removeAtIndex(index))
        Util.sharedInstance.setRewardActiveImages(rewardImages)
        Util.sharedInstance.setRedeemedImages(redeemedImages)
        self.activeTableView.reloadData()
        self.redeemedTableView.reloadData()
        
    }
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
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
