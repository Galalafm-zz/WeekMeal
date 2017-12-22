//
//  ViewController.swift
//  WeekMealDebug
//
//  Created by Louis Rialland on 18/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var refUsers: DatabaseReference!
    
    // Outlets
    @IBOutlet weak var MealsField: UITextField!
    let MealsPicker = UIPickerView()
    let MealsPickerData = [String](arrayLiteral: "7", "14")

    // Actions
    @IBAction func LaunchSearchAction(_ sender: Any) {
        updatePreference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MealsField.inputView = MealsPicker
        MealsPicker.delegate = self
        refUsers = Database.database().reference().child("users")
        
    }
    
    // Function updatePreference
    func updatePreference(){
        
        let user_uid = Auth.auth().currentUser?.uid

        self.refUsers.child(user_uid!).updateChildValues(["meals": MealsField])
        
        // Analytics
        Analytics.setUserProperty(self.MealsField.text!, forName:"meals")
    }
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.MealsPickerData.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MealsPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.MealsField.text = self.MealsPickerData[row]
    }

}
