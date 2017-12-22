//
//  RecipeViewController.swift
//  WeekMealDebug
//
//  Created by Louis Rialland on 20/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageRecipeView: UIImageView!
}

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var recipeTableView: UITableView!
    
    var refUsers: DatabaseReference!
    
    var fetchedRecipe =  [Recipe]()
    var UserData =  [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refUsers = Database.database().reference().child("users")
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        parseUser()
        
      
     
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(UserData.count > 0)
        {
            return UserData[0].meals
        }
        else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let changeRecipeAction = UITableViewRowAction(style: .default, title: "Changer", handler: { (action, indexPath) in
             self.recipeTableView.reloadRows(at: [indexPath], with: .fade)
        })
        changeRecipeAction.backgroundColor = UIColor(red:55/255.0, green:197/255.0, blue:93/255.0, alpha: 1.0)
 
        return [changeRecipeAction]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 350.0;//Choose your custom row height
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "cell") as! RecipeTableViewCell
        let randomIndex = Int(arc4random_uniform(UInt32(fetchedRecipe.count)))
       //IMAGE
        let url = URL(string: fetchedRecipe[randomIndex].image)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let img = UIImage(data: data!)
        cell.imageRecipeView?.image = img
        
        //RECIPE NAME
        let name = fetchedRecipe[randomIndex].name
        cell.nameLabel?.text = name

        
        
        //Ingredients
        var ingredientFull = "Ingrédients : "
        for ingredient in fetchedRecipe[randomIndex].ingredients {
            
            
            ingredientFull.append(ingredient + " / ")
            
        }
        
        print(ingredientFull)
        cell.ingredientLabel?.text = ingredientFull as! String
        return cell
    }
    func parseUser() {
        UserData = []
        let user_uid = Auth.auth().currentUser?.uid
        self.refUsers.child(user_uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let allergy = value?["allergy"] as? String ?? ""
            let intolerances = value?["intolerance"] as? String ?? ""
            let diet = value?["diet"] as? String ?? ""
            let meals = value?["meals"] as? Int
            self.UserData.append( User( meals: meals!, intolerances: intolerances, diet: diet, allergy: allergy) )
            self.parseData()
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    func parseData() {
    
        
        fetchedRecipe = []
        var diet = ""
        var intolerance = ""
        var allergy = ""
        if (UserData.count > 0) {
            
        if(UserData[0].diet != "") {
             diet = "&allowedDiet[]="+UserData[0].diet
        }
       
        if(UserData[0].allergy != "") {
           allergy = "&allowedAllergy[]="+UserData[0].allergy
        }

        if(UserData[0].intolerances != "") {
            intolerance = "&excludedIngredient[]="+UserData[0].intolerances
        }
        }
        else {
        }
        
        let url = "https://api.yummly.com/v1/api/recipes?_app_id=fa379d0b&_app_key=144f03fc46c9011322f8ee5c74f0b866"+diet+allergy+intolerance
        print("HEY")
        print(URL(string: url)!)
         do {
        var request = URLRequest( url: URL(string: url)! )
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration,delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error ) in
            if( error != nil ) {
                print (error)
            }
            else {
                let json = JSON(data)
                let recipes = JSON(json["matches"].arrayValue)
               
                for (index,subJSON: recipe) in recipes {
                    let imageUrlArray = recipe["smallImageUrls"]
                    let imageUrl = imageUrlArray[0].string
                    
                    
                    let nameRecipe = recipe["recipeName"].string
                    
                   
                    
                    
                    let ingredientsArray = recipe["ingredients"].arrayObject
                    
                    self.fetchedRecipe.append(Recipe(image: imageUrl!,name: nameRecipe!, ingredients: ingredientsArray as! Array<String>))
                    
                }
                
                
                
               
                
            }
            self.recipeTableView.reloadData()
            
        }
        task.resume()
        }
         catch{
            print("AIE")
        }
    }
    
    class User {
        var meals: Int
        var intolerances : String
        var diet : String
        var allergy : String
        
        init (meals : Int, intolerances : String, diet: String, allergy : String ) {
            self.intolerances = intolerances
            self.diet = diet
            self.allergy = allergy
            self.meals = meals
        }
    }
    

    class Recipe {
        var image : String
        var name : String
        var ingredients : Array<String>
        
        init (image : String, name : String, ingredients: Array<String>) {
            self.image = image
            self.name = name
            self.ingredients = ingredients
        }
    }
}
