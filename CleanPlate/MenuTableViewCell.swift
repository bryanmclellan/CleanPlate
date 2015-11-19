//
//  MenuTableViewCell.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 11/19/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuCellTitle: UILabel!
    @IBOutlet weak var menuCellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
