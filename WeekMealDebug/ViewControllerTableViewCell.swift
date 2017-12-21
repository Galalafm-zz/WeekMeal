//
//  ViewControllerTableViewCell.swift
//  WeekMealDebug
//
//  Created by Louis Rialland on 20/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var CaloriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
