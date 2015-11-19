//
//  RewardsActiveTableViewCell.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/19/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class RewardsActiveTableViewCell: UITableViewCell {

    @IBOutlet weak var rewardsActiveCellImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
