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
import FacebookLogin
import FBSDKLoginKit

class HomeViewController: UIViewController {


    
    @IBAction func LogOutAction(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                FBSDKLoginManager().logOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Inscription")
                present(vc, animated: true, completion: nil)
               
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
}
