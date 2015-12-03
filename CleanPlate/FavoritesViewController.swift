//
//  FavoritesViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/30/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var rewardImages = [String]()
    
    var restaurantNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardImages = Util.sharedInstance.getFavImages()
        restaurantNames = Util.sharedInstance.getFavRestaurantNames()
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.barTintColor = UIColor(red: 66/255.0, green: 165/255.0, blue: 245/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        menuButton.image = UIImage(named: "ic_list_2x")
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 30))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 30))
        label.textAlignment = .Right
        label.text = "Notifications"
        label.textColor = UIColor.grayColor()
        view.addSubview(label)
        view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        return view
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Notifications"
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath) as! FavoritesTableViewCell
        let image = UIImage(named: rewardImages[indexPath.row])
        
        cell.restaurantImage.layer.borderWidth = 1
        cell.restaurantImage.layer.masksToBounds = false
        cell.restaurantImage.layer.borderColor = UIColor.blackColor().CGColor
        cell.restaurantImage.layer.cornerRadius = 10
        cell.restaurantImage.clipsToBounds = true
        
        cell.restaurantImage.image = image
        cell.restaurantNameLabel.text = restaurantNames[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewardImages.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
