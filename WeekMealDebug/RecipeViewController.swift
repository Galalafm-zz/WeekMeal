//
//  RecipeViewController.swift
//  WeekMealDebug
//
//  Created by Louis Rialland on 20/12/2017.
//  Copyright © 2017 Gala Pillot. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageRecipeView: UIImageView!
}

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var recipeTableView: UITableView!
    
  
    
    var fetchedRecipe =  [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        parseData()
     
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedRecipe.count
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let changeRecipeAction = UITableViewRowAction(style: .default, title: "Changer", handler: { (action, indexPath) in
             self.recipeTableView.reloadRows(at: [indexPath], with: .fade)
        })
 
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
    
    func parseData() {
        fetchedRecipe = []
        
        let url = "https://api.yummly.com/v1/api/recipes?_app_id=fa379d0b&_app_key=144f03fc46c9011322f8ee5c74f0b866&q=onion"
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
