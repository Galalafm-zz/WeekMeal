//
//  PreferenciesViewController.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 19/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PreferenciesViewController: UIViewController {
    
    var refPreferencies: DatabaseReference!
    
    // Outlets
    @IBOutlet weak var CaloriesField: UITextField!
    @IBOutlet weak var DietField: UITextField!

    @IBOutlet weak var CheeseImageView: UIImageView!
    
    @IBAction func LaunchSearchAction(_ sender: Any) {
        addPreference()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CaloriesField.keyboardType = UIKeyboardType.numberPad

        refPreferencies = Database.database().reference().child("preferencies")
    }
    
    //  Function addPreference
    func addPreference(){
        print("yolo")
        //and also getting the generated key
        let key = refPreferencies.childByAutoId().key
        
        //creating artist with the given values
        let preference = ["id":key,
                          "calories": CaloriesField.text! as String,
                          "diet": DietField.text! as String,
                          "id_user": Auth.auth().currentUser?.uid
            ] as [String : Any]
        
        //adding the artist inside the generated unique key
        refPreferencies.child(key).setValue(preference)
    }
}

