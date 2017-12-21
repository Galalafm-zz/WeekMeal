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

<<<<<<< HEAD
class PreferenciesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var refPreferencies: DatabaseReference!
=======
class PreferenciesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
>>>>>>> 65a7cb670b942556b92c0d6c309cd3b11ddbb7de
    
    // Outlets
    @IBOutlet weak var tableViewPreferencies: UITableView!
    
    @IBOutlet weak var CaloriesField: UITextField!
    
    @IBOutlet weak var DietField: UITextField!
    let DietPicker = UIPickerView()
    let DietPickerData = [String](arrayLiteral: "Vegan", "Vegetarian", "Gluten-free", "None")
    
    @IBOutlet weak var MealsField: UITextField!
    let MealsPicker = UIPickerView()
    let MealsPickerData = [String](arrayLiteral: "7", "14")
    
    @IBOutlet weak var CheeseImageView: UIImageView!
    
    @IBAction func LaunchSearchAction(_ sender: Any) {
        addPreference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

        refPreferencies = Database.database().reference().child("preferencies")
        //observing the data changes
        refPreferencies.observe(DataEventType.value, with: { (snapshot) in
            print("CHANGE")
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                print("IL Y A DES VALEURS")
                //clearing the list
                self.preferenciesList.removeAll()
                
                //iterating through all the values
                for preferencies in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    print("ON prend les valeurs")
                    let preferenceObject = preferencies.value as? [String: AnyObject]
                    let preferenceUser_id  = preferenceObject?["id_user"]
                    let preferenceId  = preferenceObject?["id"]
                    let preferenceCalories  = preferenceObject?["calories"]
                    let preferenceDiet  = preferenceObject?["diet"]
                    //creating artist object with model and fetched values
                    let preference = PreferenceModel(id: preferenceId as! String?, calories: preferenceCalories as! String?, diet: preferenceDiet as! String?, id_user: preferenceUser_id as! String? )
                    
                    //appending it to list
                    self.preferenciesList.append(preference)
                }
                print("RELOAD")
                //reloading the tableview
                self.tableViewPreferencies.reloadData()
            }
        })
        
        
    }
    //list to store all the artist
    var preferenciesList = [PreferenceModel]()
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return preferenciesList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //the artist object
        let preference: PreferenceModel
        
        //getting the artist of selected position
        preference = preferenciesList[indexPath.row]
        
        //adding values to labels
        cell.UserLabel.text = preference.id_user
        cell.CaloriesLabel.text = preference.calories
        
        //returning cell
        return cell
=======
        CaloriesField.keyboardType = UIKeyboardType.numberPad
        
        DietField.inputView = DietPicker
        DietPicker.delegate = self
        MealsField.inputView = MealsPicker
        MealsPicker.delegate = self
        
>>>>>>> 65a7cb670b942556b92c0d6c309cd3b11ddbb7de
    }
    
    //  Function addPreference
    func addPreference(){
       
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

