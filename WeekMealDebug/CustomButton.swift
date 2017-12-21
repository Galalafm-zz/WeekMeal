//
//  CustomButton.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 20/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 4.0
        self.layer.backgroundColor = UIColor(red:55/255.0, green:197/255.0, blue:93/255.0, alpha: 1.0).cgColor
        self.tintColor = UIColor.white
    }
}
