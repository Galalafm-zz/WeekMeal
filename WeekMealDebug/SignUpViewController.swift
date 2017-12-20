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

class SignUpViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    
    
    @IBAction func CreateAccountAction(_ sender: AnyObject) {
        
        if EmailField.text == "" {
            let alertController = UIAlertController(title: "Mauvaise recette...", message: "Veuillez ne pas oublier de rentrer une adresse mail", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else if PasswordField.text == "" {
            let alertController = UIAlertController(title: "Mauvaise recette...", message: "Veuillez ne pas oublier de rentrer un mot de passe", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: EmailField.text!, password: PasswordField.text!) { (user, error) in
                
                if error == nil {
                    print("Inscription reussi ! Nous vous redirigons vers la page d'accueil.")
                    //Go on the page Home after the subscribe is succeed
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Accueil")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

}
