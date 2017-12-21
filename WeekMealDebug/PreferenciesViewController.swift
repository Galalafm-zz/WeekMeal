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

    @IBOutlet weak var MealsField: UITextField!
    let MealsPicker = UIPickerView()
    let MealsPickerData = [String](arrayLiteral: "7", "14")

    @IBOutlet weak var CheeseImageView: UIImageView!

    @IBAction func LaunchSearchAction(_ sender: Any) {
        updatePreference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CaloriesField.keyboardType = UIKeyboardType.numberPad

        DietField.inputView = DietPicker
        DietPicker.delegate = self
        MealsField.inputView = MealsPicker
        MealsPicker.delegate = self
        refUsers = Database.database().reference().child("users")

    }

    // Function updatePreference
    func updatePreference(){

        let user_uid = Auth.auth().currentUser?.uid
        
        // Convert Calories String to Int MARCHE PAS
        let CaloriesText: String!  = CaloriesField.text!
        _ = Int(CaloriesText)

        print(self.refUsers.child("users").child(user_uid!))
        self.refUsers.child(user_uid!).updateChildValues(["calories": CaloriesText])
        self.refUsers.child(user_uid!).updateChildValues(["week_diet": DietField.text!])
        
        // Analytics
        
        //convert calories string to int
        Analytics.setUserProperty(self.CaloriesField.text!, forName:"calories")
        Analytics.setUserProperty(self.MealsField.text!, forName:"meals")
        Analytics.setUserProperty(self.DietField.text!, forName:"week_diet")
    }

    // MARK: UIPickerView Delegation

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = DietPickerData.count
        if pickerView == MealsPicker {
            countrows = self.MealsPickerData.count
        }
        return countrows
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == DietPicker {
            let titleRow = DietPickerData[row]
            return titleRow
        } else if pickerView == MealsPicker {
            let titleRow = MealsPickerData[row]
            return titleRow
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == DietPicker {
            self.DietField.text = self.DietPickerData[row]
        } else if pickerView == MealsPicker {
            self.MealsField.text = self.MealsPickerData[row]
        }
    }
}
