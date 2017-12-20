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
            
            let alertController = UIAlertController(title: "Mauvaise recette...", message: "Veuillez ne pas oublier de rentrer une addresse mail", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if self.PasswordField.text == "" {
            
            //Alert the user that he have not insert password
            
            let alertController = UIAlertController(title: "Mauvaise recette...", message: "Veuillez ne pas oublier de rentrer un mot de passe", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            print("success email/password")
            
            Auth.auth().signIn(withEmail: self.EmailField.text!, password: self.PasswordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("Vous êtes maintenant connecté !")
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Preferencies")
                    self.present(vc, animated: true, completion: nil)
                    
                    
                } else {
                    print("erreu")
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Mauvaise recette...", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
}
