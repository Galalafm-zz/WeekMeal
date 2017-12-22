//
//  ResetPasswordViewController.swift
//  WeekMealDebug
//
//  Created by Gala Pillot on 19/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var EmailField: UITextField!
    
    @IBAction func ResetPasswordAction(_ sender: Any) {
        
        if self.EmailField.text == "" {
            let alertController = UIAlertController(title: "Mauvaise recette...", message: "Veuillez ne pas oublier de rentrer une addresse mail", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.EmailField.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Mauvaise recette..."
                    message = (error?.localizedDescription)!
                } else {
                    title = "Confirmation !"
                    message = "Un email vous à été envoyé pour reinitialiser votre mot de passe."
                    self.EmailField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "J'ai compris", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    
    
}
