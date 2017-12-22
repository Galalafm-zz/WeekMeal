//
//  SignUpViewController.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 19/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var refUsers: DatabaseReference!
    
    //Outlets
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    // 0 = Male & 1 = Female
    @IBOutlet weak var GenderControl: UISegmentedControl!
    
    @IBOutlet weak var SliderLabel: UILabel!
    @IBOutlet weak var AgeSlider: UISlider!
    @IBOutlet weak var CityField: UITextField!
    
    @IBOutlet weak var DietField: UITextField!
    let DietPicker = UIPickerView()
    let DietPickerData = [String](arrayLiteral: "Vegan", "Vegetarian", "Diabetic", "None")
    
    @IBOutlet weak var AllergyField: UITextField!
    @IBOutlet weak var IntoleranceField: UITextField!
    
    //Actions
    @IBAction func SliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        SliderLabel.text = "\(currentValue)"
    }
    @IBAction func CreateAccountAction(_ sender: AnyObject) {
//
//        Analytics.logEvent("sign_up", parameters: [
//            "city": self.CityField.text!,
//            ])
        
        if EmailField.text == "" {
            let alertController = UIAlertController(title: "Empty field...", message: "Please, do not forget to enter an email address !", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else if PasswordField.text == "" {
            let alertController = UIAlertController(title: "Empty field...", message: "Please, do not forget to enter a password !", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (user, error) in
                
                if error == nil {
                    print("Inscription reussie ! Nous vous redirigons vers la page d'accueil.")
                    //Go on the page Home after the subscribe is succeed
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Accueil")
                    self.present(vc!, animated: true, completion: nil)
                    
                    let key = Auth.auth().currentUser?.uid
                    
                    let user = ["age": self.SliderLabel.text! as String,
                                "email": self.EmailField.text! as String,
                                "gender": self.GenderControl.selectedSegmentIndex as Int,
                                "city": self.CityField.text! as String,
                                "diet": self.DietField.text! as String,
                                "allergy": self.AllergyField.text! as String,
                                "intolerance": self.IntoleranceField.text! as String,
                                "calories": 1400 as Int,
                                "week_diet": "" as String,
                                "meals": 7 as Int,
                                "wishes": [] as Array,
                                "declined_meals": [] as Array,
                                "accepted_meals": [] as Array
                        ] as [String : Any]
                    
                    self.refUsers.child(key!).setValue(user)
                    
                    // Analytics
                    
                    //convert age string to int
                    Analytics.setUserProperty(self.SliderLabel.text!, forName:"age")
                    Analytics.setUserProperty(self.CityField.text!, forName:"city")
                    Analytics.setUserProperty(self.DietField.text!, forName:"diet")
                    Analytics.setUserProperty(self.AllergyField.text!, forName:"allergics")
                    Analytics.setUserProperty(self.IntoleranceField.text!, forName:"intolerances")
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DietField.inputView = DietPicker
        DietPicker.delegate = self
        
        refUsers = Database.database().reference().child("users")
    }
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DietPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DietPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.DietField.text = self.DietPickerData[row]
    }

}
