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

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Outlets
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBOutlet weak var GenderField: UISegmentedControl!
    
    @IBOutlet weak var CityField: UITextField!
    
    @IBOutlet weak var DietField: UITextField!
    let DietPicker = UIPickerView()
    let DietPickerData = [String](arrayLiteral: "Vegan", "Vegetarian", "Diabetic", "None")
    
    @IBOutlet weak var AllergyField: UITextField!
    
    //Actions
    @IBAction func CreateAccountAction(_ sender: AnyObject) {
        
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
