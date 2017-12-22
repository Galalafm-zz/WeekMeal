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
import FirebaseDatabase


class PreferenciesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var refUsers: DatabaseReference!

    // Outlets
    @IBOutlet weak var CaloriesField: UITextField!

    @IBOutlet weak var DietField: UITextField!
    let DietPicker = UIPickerView()
    let DietPickerData = [String](arrayLiteral: "Vegan", "Vegetarian", "Gluten-free", "None")

    @IBAction func LaunchSearchAction(_ sender: Any) {
        updatePreference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CaloriesField.keyboardType = UIKeyboardType.numberPad

        DietField.inputView = DietPicker
        DietPicker.delegate = self

        refUsers = Database.database().reference().child("users")

    }

    // Function updatePreference
    func updatePreference(){

        let user_uid = Auth.auth().currentUser?.uid
        
        // Convert Calories String to Int MARCHE PAS
        let CaloriesText: String!  = CaloriesField.text!
        let CaloriesInt = Int(CaloriesText)
        let preferences = ["calories": CaloriesInt ,
                           "week_diet": DietField.text! as String,
            ] as [String : Any]
        print(self.refUsers.child(user_uid!))
        self.refUsers.child(user_uid!).updateChildValues(["calories": CaloriesText])

        self.refUsers.child(user_uid!).updateChildValues(["calories": CaloriesText])
        self.refUsers.child(user_uid!).updateChildValues(["week_diet": DietField.text!])
        
        // Analytics
        Analytics.logEvent("preferences", parameters: [
            "week_diet": self.DietField.text!,
            "calories": self.CaloriesField.text!
            ])
    }

    // MARK: UIPickerView Delegation

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.DietPickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DietPickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.DietField.text = self.DietPickerData[row]
    }
}
