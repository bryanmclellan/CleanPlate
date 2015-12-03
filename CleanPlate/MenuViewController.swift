//
//  MenuViewController.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/13/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var CellLabels = ["Home", "Recent", "Rewards", "PlatesServed", "Favorites"]
    var CellImages = ["ic_home_3x", "ic_update_3x", "ic_card_giftcard_3x", "ic_local_dining_3x", "ic_favorite_3x"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuTableViewCell

        cell.menuCellTitle.text = CellLabels[indexPath.row]
        let closeImage = UIImage(named:CellImages[indexPath.row])?.imageWithRenderingMode(
            UIImageRenderingMode.AlwaysTemplate)
        cell.menuCellImage.image = closeImage!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(CellLabels[indexPath.row] + "Segue", sender: self)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellImages.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
