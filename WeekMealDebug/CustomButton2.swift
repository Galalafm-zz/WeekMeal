//
//  CustomButton2.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 21/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit

class CustomButton2: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 4.0
        self.layer.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0).cgColor
    }
}
