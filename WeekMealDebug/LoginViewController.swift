//
//  LoginViewController.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 19/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func LoginAction(_ sender: UIButton) {
        print("click bouton")
        if self.EmailField.text == ""  {
            
            //Alert the user that he have not insert email
            
            let alertController = UIAlertController(title: "Bad recipe...", message: "Please, do not forget to enter an email address !", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if self.PasswordField.text == "" {
            
            //Alert the user that he have not insert password
            
            let alertController = UIAlertController(title: "Bad recipe...", message: "Please, do not forget to enter a password !", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            print("success email/password")
            
            Auth.auth().signIn(withEmail: self.EmailField.text!, password: self.PasswordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You're successfully connected !")
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Preferencies")
                    self.present(vc, animated: true, completion: nil)
                    
                    
                } else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Bad recipe...", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
